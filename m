Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8AA6E6EB2
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 23:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbjDRVyQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 17:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjDRVyP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 17:54:15 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91D892
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 14:54:14 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id x8-20020a17090a6b4800b002474c5d3367so182556pjl.2
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 14:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681854854; x=1684446854;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lq+MIeT6VUZIqyvWU3U2GT9/aA3Njvk96gOZqMA3DyQ=;
        b=GxEZo0cBa7VKkbdJ7Fqgl++aEv/cmpiaQNi86TM/yFjKn4bRwu8ypxsNvKbDx0Tcah
         VTVFFkVnPdTjRlGE6/vbnQEk7qrOF2dXH9td2UJe9a+9f+/nMHTIHqX+SKF7Rn/jz5QR
         lJY7Hf8MHLAS4M+fgMSJoxEXL96cPBL0B06bXTwV7ZS5zLHlWEQSZDQTEfny2ZVNiIza
         N2N/aTZyKRBXQ3ThVqbZDfBSGrwAc6A7he6K8EmBGekauEVwU2uibez6Fs3u/GlcoZ4b
         TbSWYjOXHEKRHxnQz46RaCKVWbcx4BEmfwDAK0LoPmSyS2hX8Yy++d88d8yO0CqHbFJB
         Yxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681854854; x=1684446854;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lq+MIeT6VUZIqyvWU3U2GT9/aA3Njvk96gOZqMA3DyQ=;
        b=OM2dDNU51WQV4vzIatRW+S3YjSfJvJokOyvODQ8fy0GE2BKXKR6YAEH5EB9y9L1lLX
         sQaq8tQt3Be8spl7I1uUsUZ7fNMOjQZZAkkqN4seb6yB67eMUg7bWMySQTHz2QaazmXY
         Qs9C6YT9/hkf3IVAmGI0ni681c9BYXqvSl8pK4zzmio1FkhvYy7+wIX6W3gadXOKKlO3
         eEHQxyEzWN+Qy6e9Ob9Ex2U3hQ9YWn3M+zOPRT46g+FNhbabjfqWez6xoz255LbIOhJF
         A6dK/dIw6alBT5R67ykid4SLqRKjbSsDoNUB1wMAk8jn5eCql7o0kY+2ebv6a5Pib2xC
         sAyw==
X-Gm-Message-State: AAQBX9e9OOZNe8ltow2oPc1UvDJTwvFwKeslj3aT9ses5daBuayqBZs1
        YC93fe5B2V/EbCTILbjJRME=
X-Google-Smtp-Source: AKy350YGh+9PGqbopj0oh5K3R50s2uNwGvcZRoCyt5XZxp6xKZBn2xyh9cZgSzwINRdEZ8unEo+VEw==
X-Received: by 2002:a05:6a20:8e0e:b0:e8:d218:739f with SMTP id y14-20020a056a208e0e00b000e8d218739fmr188134pzj.21.1681854854018;
        Tue, 18 Apr 2023 14:54:14 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e1::13b2? ([2620:10d:c090:400::5:569b])
        by smtp.gmail.com with ESMTPSA id l15-20020a654c4f000000b0051a3c744256sm9201010pgr.93.2023.04.18.14.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 14:54:13 -0700 (PDT)
Message-ID: <3a74e39a-8216-39d4-8b30-aee12d816a3e@gmail.com>
Date:   Tue, 18 Apr 2023 14:54:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH bpf-next] bpftool: Show map IDs along with struct_ops
 links.
Content-Language: en-US, en-ZW
To:     Quentin Monnet <quentin@isovalent.com>,
        Kui-Feng Lee <thinker.li@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        yhs@meta.com, song@kernel.org, kernel-team@meta.com,
        andrii@kernel.org, Kui-Feng Lee <kuifeng@meta.com>
References: <20230418002917.519492-1-kuifeng@meta.com>
 <CACdoK4+UAtYxncMBveNRgHvv0LW8zGiXfA-gtOqGat-Thsu3vQ@mail.gmail.com>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CACdoK4+UAtYxncMBveNRgHvv0LW8zGiXfA-gtOqGat-Thsu3vQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/18/23 14:44, Quentin Monnet wrote:
> On Tue, 18 Apr 2023 at 01:29, Kui-Feng Lee <thinker.li@gmail.com> wrote:
>>
>> A new link type, BPF_LINK_TYPE_STRUCT_OPS, was added to attach
>> struct_ops to links. (226bc6ae6405) It would be helpful for users to
>> know which map is associated with the link.
>>
>> The assumption was that every link is associated with a BPF program,
>> but this does not hold true for struct_ops. It would be better to
>> display map_id instead of prog_id for struct_ops links. However, some
>> tools may rely on the old assumption and need a prog_id displayed in
>> the link header line.  By keeping the prog_id unchanged, an extra line
>> indicating the map_id is displayed.
>>
>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> 
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> 
> Thanks! What does the prog_id correspond to, for this type of links?
> If it's not relevant at all we could at least take it out from the
> plain output maybe, tools that want to parse the output should stick
> to JSON.

The prog_id is irrelevant here.  Since our convention is to let tools 
parse JSON, I will move map_id to the header line of plain text output 
and remove the prog_id, just like you said.
