Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF595A1589
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 17:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241339AbiHYPX7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 11:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240942AbiHYPX4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 11:23:56 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6B1B95AB
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 08:23:46 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v7-20020a1cac07000000b003a6062a4f81so2899558wme.1
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 08:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=H2I5TElNZYzyAJK6JkaZO1xlJ//5MZXhH88RV4kU+ZE=;
        b=uMCavZzAgNFAS43Nh/wYBreeIKgW/H4ZBnx+1MibRVxsJ6RZ8fqaNrMgmmTIIuEKXn
         33i0I8BSdcNFx3JovCXuTW/xk/sCvGD+DBJddIFUDmz0j0za2AGykt2RN7Cx0WgXVmwN
         4mJ6xdJSfSDYltc6i3J0jfOfBJbIkxaIPCwuaXmVFv57K/A+Hp7BsY25egoejQ68bF85
         x3uNf6yphy73aPUPLDBrqeSAXYScET8rSA5qJyDUhqTBdSHmWgrzfFLknHbgaCQolqfe
         q4593i09/VNxBJUbLXzlaslKdsWt3nRkKoql8J9Lyf7+tA4354DSe12I9jFS0MZmRGwT
         LiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=H2I5TElNZYzyAJK6JkaZO1xlJ//5MZXhH88RV4kU+ZE=;
        b=lHJWNMgMTiAiCStoLy//gKVAwkL96e3Pw+Ridow5XFl8vdxrvoC8La3KtlJZr8qCwd
         5X1IBxl0sI7PeeuXOktu6xwoc3cjgdNtHt61fJMZFc2qGqwLPOHoorqCyBHpXTyaPlPf
         Gn+tlnzJ2nNlbIaJMT920EEbycIgAP9ja1B/4uMzST39erAb3Lc6e+yW9DEijjD9P4pT
         zoL4s7m27O5ds+kX61a34Z7bNrp5sznNxN8i4a+Ts3cEoqsWg7Qv8pSzXR2uMNeQBr6L
         C4lsfA7/RgfUiI9IQkhx1ZhSdjUR8asaEq2KRHHTwkr6CF943kYJ9Y8aFbXo6tw6W/e1
         7c+g==
X-Gm-Message-State: ACgBeo1HwNvnjE2080TCn41SngqhnSYb8JZ3aV2TSZsRZ1eWtMgpHSgD
        KIRx3MMZWmWLmaIT6qvHWLTGAQ==
X-Google-Smtp-Source: AA6agR5dQ1tz3j4m1ZhehRbrKaR6JX3ebP0E5kY6LPO6vaGTmWYbgu8cyLPnXqJU5DHiDrwLtpCf7w==
X-Received: by 2002:a7b:c84c:0:b0:3a5:dde3:2a9e with SMTP id c12-20020a7bc84c000000b003a5dde32a9emr9121330wml.84.1661441024694;
        Thu, 25 Aug 2022 08:23:44 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id m9-20020adfe0c9000000b00225206dd595sm19661825wri.86.2022.08.25.08.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 08:23:44 -0700 (PDT)
Message-ID: <89edec7d-7878-44b0-a050-f5daef69a0a1@isovalent.com>
Date:   Thu, 25 Aug 2022 16:23:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH bpf-next v2] bpf: Fix a few typos in BPF helpers
 documentation
Content-Language: en-GB
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Jakub Wilk <jwilk@jwilk.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        linux-man <linux-man@vger.kernel.org>
References: <20220825110216.53698-1-quentin@isovalent.com>
 <CAADnVQKdXUjBnq2P5hLahtGnJh6-_8bgQFFRr_EyykTRZb8Ujw@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CAADnVQKdXUjBnq2P5hLahtGnJh6-_8bgQFFRr_EyykTRZb8Ujw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 25/08/2022 15:57, Alexei Starovoitov wrote:
> On Thu, Aug 25, 2022 at 4:02 AM Quentin Monnet <quentin@isovalent.com> wrote:
>> index 4fb685591035..0487ee06edef 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -79,7 +79,7 @@ struct bpf_insn {
>>  /* Key of an a BPF_MAP_TYPE_LPM_TRIE entry */
>>  struct bpf_lpm_trie_key {
>>         __u32   prefixlen;      /* up to 32 for AF_INET, 128 for AF_INET6 */
>> -       __u8    data[0];        /* Arbitrary size */
>> +       __u8    data[]; /* Arbitrary size */
> 
> Sigh. Looks like you didn't even run the build of selftests.
> Please see relevant commits in bpf tree.

The rest of the patch is a fix on typos, in comments, so indeed I did
not :/. I missed the commit from Daniel and should have been more
cautious about the above, apologies. I'll send a new version without it.

Quentin
