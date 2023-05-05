Return-Path: <bpf+bounces-106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3839C6F7E29
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 09:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74E4F1C21731
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 07:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6634C93;
	Fri,  5 May 2023 07:51:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFCC185F
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 07:51:49 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7941F2133
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 00:51:47 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64115e652eeso17898503b3a.0
        for <bpf@vger.kernel.org>; Fri, 05 May 2023 00:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683273107; x=1685865107;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m63UGtt6cn6Zj4stZbSBMR+jtVNTlKAVq6/NOrDEYiY=;
        b=Ps6tpgkmGDBTgiUcihDWhGd8icSDmSW2Z4Zw6ZArK/MQbncpP08Ri1j1oRNH4RfO76
         p/fv9c9LCYFWaYLs1OxUtDDnA85ajCakB0Zl/eLtCkaa/emgYg/iS2N2zM7ynxTRKNxF
         2F7JJguL/kvV3WnnMYzUyc07QDxJ9iD204OgONFCyPebu2fvX7RqE3GbTi3yA/Qs2V8/
         LqnIJJXRNqhBZ2o+50zrNWR4GyzY7wLnPin7sArRH9nA2BTUvHb3d5eesqNl9qAoRM/3
         Xk49AmfPbzy/VVatSVkDuqwWYbHPq5CKbLMhP6PUivxKZVPjDW47HIHjVHJbJ7COiXld
         lURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683273107; x=1685865107;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m63UGtt6cn6Zj4stZbSBMR+jtVNTlKAVq6/NOrDEYiY=;
        b=ZlH/pOj0jUnKSbMXDONVnitVsGCvXM4dAf/9n11PGUZmuwtALOUusdEiM4GV3ROdtB
         FfUXMj4H3Ymbp9ZkCvaLlkFJGlUooDU2dKSVItENfoIx+9iMyXQFGhESauJ1TtPFCla8
         hSsxDvtjocjDxGS3aaSUJt18myvQ+PyEBmtqN8dhnb4Hiahxfhz59yhENe8mIW1oOPs2
         lChBR5g9IUcoVDmVw9s1gCSqgYCnZxykyi/3JgqjBRiCkfxTtKf8A4+dsC0hB7OZD5+A
         ca5pciUZhk29nRdnOqlWqjuSA5YNLdZw1xwf/3RqJWezOwdzEWVJoniUJSeqfyLRSAhf
         +g2g==
X-Gm-Message-State: AC+VfDzW/QgaL9u60CmMCRQ/uLNZoLYKerWaqdQAPipaR48Hnw4f60tB
	S9iiGvw82mJkX441EBd605o=
X-Google-Smtp-Source: ACHHUZ6o5AS4p7EgZ3kNKA9zNI078Xjvyt7GDUwP5bcc7hawZAQ6FeZ6BiNemOqSFBPGWxjk0iiWyg==
X-Received: by 2002:a17:90b:38c2:b0:24d:f67d:7177 with SMTP id nn2-20020a17090b38c200b0024df67d7177mr5719106pjb.20.1683273106841;
        Fri, 05 May 2023 00:51:46 -0700 (PDT)
Received: from [10.71.57.173] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id w6-20020a17090aea0600b0024bb5fb51fcsm6518485pjy.34.2023.05.05.00.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 00:51:46 -0700 (PDT)
Message-ID: <c9543049-ef85-88da-5c55-42bed4819c5d@gmail.com>
Date: Fri, 5 May 2023 15:51:42 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: bpf: add support to check kernel features in BPF program
To: Menglong Dong <menglong8.dong@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Alan Maguire <alan.maguire@oracle.com>
Cc: bpf <bpf@vger.kernel.org>
References: <CADxym3ax73kYEyJMZwN+bTwmX9VhZ3WJe+wC9RGGwpfdjLdf3g@mail.gmail.com>
From: zf <zf15750701@gmail.com>
In-Reply-To: <CADxym3ax73kYEyJMZwN+bTwmX9VhZ3WJe+wC9RGGwpfdjLdf3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

在 2023/5/4 19:09, Menglong Dong 写道:
> Hello,
> 
> I find that it's not supported yet to check if the bpf features are
> supported by the target kernel in the BPF program, which makes
> it hard to keep the BPF program compatible with different kernel
> versions.
> 
> For example, I want to use the helper bpf_jiffies64(), but I am not
> sure if it is supported by the target, as my program can run in
> kernel 5.4 or kernel 5.10. Therefore, I have to compile two versions
> BPF elf and load one of them according to the current kernel version.
> The part of BPF program can be this:
> 
> #ifdef BPF_FEATS_JIFFIES64
>    jiffies = bpf_jiffies64();
> #else
>    jiffies = 0;
> #endif
> 
> And I will generate xxx_no_jiffies.skel.h and xxx_jiffies.skel.h
> with -DBPF_FEATS_JIFFIES64 or not.
> 
> This method is too silly, as I have to compile 8(2*2*2) versions of
> the BPF program if I am not sure if 3 bpf helpers are supported by the
> target kernel.
> 
> Therefore, I think it may be helpful if we can check if the helpers
> are support like this:
> 
> if (bpf_core_helper_exist(bpf_jiffies64))
>    jiffies = bpf_jiffies64();
> else
>    jiffies = 0;
> 
> And bpf_core_helper_exist() can be defined like this:
> 
> #define bpf_core_helper_exist(helper)                        \
>      __builtin_preserve_helper_info(helper, BPF_HELPER_EXISTS)
> 
> Besides, in order to prevent the verifier from checking the helper
> that is not supported, we need to remove the dead code in libbpf.
> As the kernel already has the ability to remove dead and nop insn,
> we can just make the dead insn to nop.
> 
> Another option is to make the BPF program support "const value".
> Such const values can be rewrite before load, the dead code can
> be removed. For example:
> 
> #define bpf_const_value __attribute__((preserve_const_value))
> 
> bpf_const_value bool is_bpf_jiffies64_supported = 0;
> 
> if (is_bpf_jiffies64_supported)
>    jiffies = bpf_jiffies64();
> else
>    jiffies = 0;
> 
> The 'is_bpf_jiffies64_supported' will be compiled to an imm, and
> can be rewrite and relocated through libbpf by the user. Then, we
> can make the dead insn 'nop'.
> 
> What do you think? I'm not sure if these methods work and want
> to get some advice before coding.
> 
> Thanks!
> Menglong Dong

Maybe you can use like this
bpf_core_enum_value_exists(enum bpf_func_id, BPF_FUNC_jiffies64);


