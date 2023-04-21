Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDD66EAEEE
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 18:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjDUQVK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 12:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjDUQVJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 12:21:09 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC713212C
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 09:21:06 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-b8f5121503eso2479281276.1
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 09:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682094065; x=1684686065;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rDBYsu0Kkeg8+k/fpLfBkAa9CJm5I9LxEz8usqXQ4IU=;
        b=DF0xmHKPPLAOg66Du2culDIqhVgXuANUPqdqUGHYrYV2CHyWVow1Db20ja9akftQHR
         5kycEtMcZL6+vxypgtIVccEePm+4b3sH6+MARr/lvQPTnuh8jpBvPHFtUnA6q+Q0Wlt3
         VoyhhTnNrnrp7qp7Srf+WCWwjLBW1DIialp1YoPIf18SYVmvG2SaUy01ovRzD1eNxHvy
         upLX4/5TGp1PLasnyrcye9AP6hzr99v9aqIruRzNPNRlA9agWdA4vWubqDx9KGWvhmAI
         o1074kpnFj+TRXMECo7reyHzc9LUgskJ6mkhku32AP3WIJ6ehjImF4VV76MO3CbCbN+m
         zQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682094065; x=1684686065;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rDBYsu0Kkeg8+k/fpLfBkAa9CJm5I9LxEz8usqXQ4IU=;
        b=K5UkKohu0egnl/MelzBARiwXawqQDBFB3nLlEuIKmofegdFLLpi5CRA+Fpyc+fAr0n
         Y89ZGU9jy30cRj4SgHiuWjfQ7Ud3V2u4LlTZ5G0Al0IzuD12/Gi3lbzIJH2d2jGj0aqq
         h4ZJXtAAlmxYHQ4NyjwqAYe/gnoITrTbpr/gnunPpSibLcQAtKtsW5umawSNUWR93STp
         skZnIdf47xC9obzimJUd4ujaIrwmbLKzwBn45OL9s5TpVIYjDs47u9Liif6i3eYykp2A
         prlV1QeAUzVMh6X8i4Ij9d/TfAM47M4wqNsPvGQzSFLM1Ywz2WA+8IL3H2yie/rKuowr
         Np/Q==
X-Gm-Message-State: AAQBX9eRXfzMExw8QrBEAw+4oynt+Dw6SqDzPS09HRF2q0sXSR06Udsl
        zYXP4tQO0FaFX0n6fvIuxsM=
X-Google-Smtp-Source: AKy350aEUj+kFAQ/8JYK4muu4qsSReNQ0rMzWPnJRg71VOr6FQotSb8OEJNXHhMCAoAGX4Ex1phFOQ==
X-Received: by 2002:a0d:e68b:0:b0:54f:9e41:df5a with SMTP id p133-20020a0de68b000000b0054f9e41df5amr2380416ywe.15.1682094065711;
        Fri, 21 Apr 2023 09:21:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:724e:a12f:f4b3:597b? ([2600:1700:6cf8:1240:724e:a12f:f4b3:597b])
        by smtp.gmail.com with ESMTPSA id e131-20020a816989000000b0054f50f71834sm1022129ywc.124.2023.04.21.09.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 09:21:05 -0700 (PDT)
Message-ID: <5f23696d-d7bd-774d-c45a-8a6bb13b9cb5@gmail.com>
Date:   Fri, 21 Apr 2023 09:21:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH bpf-next v2] bpftool: Show map IDs along with struct_ops
 links.
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kui-Feng Lee <thinker.li@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        yhs@meta.com, song@kernel.org, kernel-team@meta.com,
        andrii@kernel.org, Kui-Feng Lee <kuifeng@meta.com>,
        Quentin Monnet <quentin@isovalent.com>
References: <20230419003651.988865-1-kuifeng@meta.com>
 <CAEf4BzY3DOYZOQBfvvOEGdKaUF+M8DS8Q33devTWzjcEHkOuQg@mail.gmail.com>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzY3DOYZOQBfvvOEGdKaUF+M8DS8Q33devTWzjcEHkOuQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/20/23 16:41, Andrii Nakryiko wrote:
> On Tue, Apr 18, 2023 at 5:37 PM Kui-Feng Lee <thinker.li@gmail.com> wrote:
>>
>> A new link type, BPF_LINK_TYPE_STRUCT_OPS, was added to attach
>> struct_ops to links. (226bc6ae6405) It would be helpful for users to
>> know which map is associated with the link.
>>
>> The assumption was that every link is associated with a BPF program, but
>> this does not hold true for struct_ops. It would be better to display
>> map_id instead of prog_id for struct_ops links. However, some tools may
>> rely on the old assumption and need a prog_id.  The discussion on the
>> mailing list suggests that tools should parse JSON format. We will maintain
>> the existing JSON format by adding a map_id without removing prog_id. As
>> for plain text format, we will remove prog_id from the header line and add
>> a map_id for struct_ops links.
>>
>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
>> ---
>>   tools/bpf/bpftool/link.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
>> index f985b79cca27..8eb8520bd7b4 100644
>> --- a/tools/bpf/bpftool/link.c
>> +++ b/tools/bpf/bpftool/link.c
>> @@ -195,6 +195,10 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
>>                                   info->netns.netns_ino);
>>                  show_link_attach_type_json(info->netns.attach_type, json_wtr);
>>                  break;
>> +       case BPF_LINK_TYPE_STRUCT_OPS:
>> +               jsonw_uint_field(json_wtr, "map_id",
>> +                                info->struct_ops.map_id);
>> +               break;
>>          default:
>>                  break;
>>          }
>> @@ -227,7 +231,10 @@ static void show_link_header_plain(struct bpf_link_info *info)
>>          else
>>                  printf("type %u  ", info->type);
>>
>> -       printf("prog %u  ", info->prog_id);
>> +       if (info->type == BPF_LINK_TYPE_STRUCT_OPS)
>> +               printf("map_id %u  ", info->struct_ops.map_id);
>> +       else
>> +               printf("prog %u  ", info->prog_id);
> 
> if we output "prog %u" for prog_id, shouldn't we just output "map %u"
> for map_id?

"map" make sense to me.

> 
>>   }
>>
>>   static void show_link_attach_type_plain(__u32 attach_type)
>> --
>> 2.34.1
>>
