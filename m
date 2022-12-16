Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4295464E7A9
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 08:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiLPHSb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 02:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLPHS1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 02:18:27 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847F2140FC;
        Thu, 15 Dec 2022 23:18:26 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so1529393pjj.4;
        Thu, 15 Dec 2022 23:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LoI4pJkE4HRFm+A/ns6ZyJwDNVOzs5SHMr59ADiuZAo=;
        b=VyV3Ra1Xd3+V9gtAPG2QpUCC1yrE6MRKENJp8ooyjAmiT+pES3D6M//mRwGqk7jMC9
         /ExGHNjpycDrpBwSVutq5XXo3IsZb6CVVtu7gIHdXc+HbMyfonXqzu2UqjAZUkWPnYmd
         bfQYzgOqvp/biH9uKZrDypJnFQ/+DWbfAQFkZztoeCME09BA9BJ4A9pRa9LXKRfOWKeU
         +iCq1sLeauWqELx5ZUZ+I9xFvKLVU68qqHFC6Nz/2zIQHUDlHTxwq3vS8Cl4Kk6eKhml
         Ubj4x3hs5x8ABgUg61jPqq+48wj1sTeesKDE5focHrAKMAwSvKoviEev9SMi4MezvoM8
         o5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LoI4pJkE4HRFm+A/ns6ZyJwDNVOzs5SHMr59ADiuZAo=;
        b=oIWpykX+UX4PBoPBI2yenVZCbPYGJ6EOGu9416i2WO27LlPb52imkujB9EOQ4i/Uqk
         JOA6XXmbWiEw049P7ATLzjp4Tj0NK8FdC6okKa9/pFQvp9F2bDVhi5LAblaRBSKw6r7e
         ZKPgPgEV8X3SJn6hIz+CjeVJS9I+5W+6r890XRoxvF7cqc36/gtSDEUucRaO5/zK3+dt
         i6gL8t3Gr1zkhljn9zP32Cjd3bmLwJt3jPZQkRQI5DrItPaZbJ2VxmXjnwMlJJOFSV6o
         zvO9YXJISPwdF0z4suV8xWqNczK2pPkDDf4eW6UBZWVDvLq6efoPYLxAeFy/jPoycv1h
         BQgg==
X-Gm-Message-State: ANoB5pnpFwQSldBdfSYwtZX8pS8pQPXYtGFPWBJ3S0DrW6YKJ4YrrvqP
        a0+bFRoFFgG6KWWMnpyyxA==
X-Google-Smtp-Source: AA0mqf4GGZXzMfxfcXa0LYgNPrKXHrfcFkoBkTUtKDVEqUUgkikU0E8/5SYXFa4Pn7vXXirNyEZitA==
X-Received: by 2002:a17:90b:a0a:b0:223:2038:343a with SMTP id gg10-20020a17090b0a0a00b002232038343amr13501130pjb.8.1671175105758;
        Thu, 15 Dec 2022 23:18:25 -0800 (PST)
Received: from smtpclient.apple ([144.214.0.6])
        by smtp.gmail.com with ESMTPSA id v17-20020a63d551000000b00477bdc1d5d5sm860161pgi.6.2022.12.15.23.18.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Dec 2022 23:18:25 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH bpf-next] bpf: dup xlated insns with kvmalloc+memcpy
From:   Hao Sun <sunhao.th@gmail.com>
In-Reply-To: <fa3c59e3-da85-aec3-d7bb-6360c842042c@meta.com>
Date:   Fri, 16 Dec 2022 15:18:11 +0800
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, jolsa@kernel.org,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6523CED9-3532-40CB-8B50-5C137555E58E@gmail.com>
References: <20221216055436.4698-1-sunhao.th@gmail.com>
 <fa3c59e3-da85-aec3-d7bb-6360c842042c@meta.com>
To:     Yonghong Song <yhs@meta.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On 16 Dec 2022, at 3:03 PM, Yonghong Song <yhs@meta.com> wrote:
>=20
>=20
>=20
> On 12/15/22 9:54 PM, Hao Sun wrote:
>> Currently, kmemdup() is used for allocating and copying xlated insns
>> in bpf_insn_prepare_dump(). The following warning can be triggered
>> when dup large amount of insns (roughly BPF_COMPLEXITY_LIMIT_INSNS/2)
>> because kmemdup() uses kmalloc() which would fail when allocing size
>> is too big, leading to failure in dump xlated insns:
>> WARNING: CPU: 2 PID: 7060 at mm/page_alloc.c:5534
>> Call Trace:
>>  <TASK>
>>  __alloc_pages_node include/linux/gfp.h:237 [inline]
>>  alloc_pages_node include/linux/gfp.h:260 [inline]
>>  __kmalloc_large_node+0x81/0x160 mm/slab_common.c:1096
>>  __do_kmalloc_node mm/slab_common.c:943 [inline]
>>  __kmalloc_node_track_caller.cold+0x5/0x5d mm/slab_common.c:975
>>  kmemdup+0x29/0x60 mm/util.c:129
>>  kmemdup include/linux/fortify-string.h:585 [inline]
>>  bpf_insn_prepare_dump kernel/bpf/syscall.c:3820 [inline]
>>  bpf_prog_get_info_by_fd+0x9a3/0x2cb0 kernel/bpf/syscall.c:3975
>>  bpf_obj_get_info_by_fd kernel/bpf/syscall.c:4297 [inline]
>>  __sys_bpf+0x3928/0x56f0 kernel/bpf/syscall.c:5004
>>  __do_sys_bpf kernel/bpf/syscall.c:5069 [inline]
>>  __se_sys_bpf kernel/bpf/syscall.c:5067 [inline]
>>  ...
>> So use kvmalloc()+memcpy() to fix this, for small size of insns,
>> this is same as kmemdup(), but this also support dup large amount
>> of xlated insns.
>> Signed-off-by: Hao Sun <sunhao.th@gmail.com>
>> ---
>>  kernel/bpf/syscall.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 35972afb6850..06229fddac0d 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -3831,10 +3831,10 @@ static struct bpf_insn =
*bpf_insn_prepare_dump(const struct bpf_prog *prog,
>>   u8 code;
>>   int i;
>>  - insns =3D kmemdup(prog->insnsi, bpf_prog_insn_size(prog),
>> - GFP_USER);
>=20
> Does kmemdup(prog->insnsi, bpf_prog_insn_size(prog), GFP_USER | =
__GFP_NOWARN) work?

This only suppress the warning, bpf_insn_prepare_dump() still fails =
because of
the failure of kmalloc() invoked by kmemdup().=20

>=20
>> - if (!insns)
>> + insns =3D kvmalloc(bpf_prog_insn_size(prog), GFP_USER | =
__GFP_NOWARN);
>> + if (unlikely(!insns))
>>   return insns;
>> + memcpy(insns, prog->insnsi, bpf_prog_insn_size(prog));
>>     for (i =3D 0; i < prog->len; i++) {
>>   code =3D insns[i].code;
>> @@ -3992,7 +3992,7 @@ static int bpf_prog_get_info_by_fd(struct file =
*file,
>>   uinsns =3D u64_to_user_ptr(info.xlated_prog_insns);
>>   ulen =3D min_t(u32, info.xlated_prog_len, ulen);
>>   fault =3D copy_to_user(uinsns, insns_sanitized, ulen);
>> - kfree(insns_sanitized);
>> + kvfree(insns_sanitized);
>>   if (fault)
>>   return -EFAULT;
>>   }
>> base-commit: 0e43662e61f2569500ab83b8188c065603530785

