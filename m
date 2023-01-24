Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844F467A119
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 19:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbjAXS0I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 13:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjAXS0H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 13:26:07 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAB54B4AF
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 10:26:03 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id a18so3022355plm.2
        for <bpf@vger.kernel.org>; Tue, 24 Jan 2023 10:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e/0mhQjUX3YGT74X00F8z++e1kC7KtXcE8nvjwTMUBw=;
        b=BsUQ1hllhvS6HJrLSXD7+MzcNynbgKQg8PwmHl+xYCATUVwS3kp+oACR4ntufcFLXb
         v6HkcZHDdZjE9Z9HGHnugoNzS38J9+8X6sVLsZJoTYWKtRQfzwrTDZ4qv2hUtVDWJW6D
         yTZ5WdCyMTjTD47xPG2ASxlJqS+MyNEdZmZVAaH0wfnDDYP34h2cG5xOoHy/TSkVvS7A
         B3KNdH02o/H0ISP8uEhMysxk/0yke8lvtUNlIfipL94HC4p63lVVw2T1DEQUBxWdwVNt
         82s6YZUDLz/XXAqUx7MvzaXZ4WAsQ498WHsM/LLiiHVWJf6AJNTLTVcNYS8kP6fde/wi
         bhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e/0mhQjUX3YGT74X00F8z++e1kC7KtXcE8nvjwTMUBw=;
        b=xbk1EBFFz3HL1XcdBRfc6d9XBnRcWeV/arjSaGxxdnP/jvbMOxnSTxg4PbgUTXsZ08
         d0xdNbjVK2Tj+M9HT/A6n0O4hLiqPp0XuP0h1jAtr2wjI7BQ/HZhmkfShpmFST1b/t7B
         GIABggVXDtTfr/+RPZQ+UEr9HBmvIzJUXjMIY/4Dx8viKgQ6rEqMv00Iu3z9JVkk2Vgy
         eWT7oC2OBosGcKsJOPPu/E7l292uOI0BZeLWPmfPnbs6MaQ0dzlGDFK7vvjBr9guAZcz
         S7Jfyy9OpLWIOmCh5xG1TlL9WmiKGiJlfIHUC3VFdUi0LWRIW4YWJHdULOGBktVkTaiV
         0+2g==
X-Gm-Message-State: AFqh2kqfdc1VQ4rkinay41H+eeRrzndrUwD2K6eRj98Ani8M6bBhs+XO
        GdKuMTzpL49wXoivc9ExkBi2Ed+Oj/K7gA==
X-Google-Smtp-Source: AMrXdXvOSfRburI4w7KdIV5UHVnOos3psQ4pMuIPXXELpPJlsCTLWRgG3rUAGatRkN5E1Q2xQtw06Q==
X-Received: by 2002:a17:90b:3842:b0:22b:b3df:d970 with SMTP id nl2-20020a17090b384200b0022bb3dfd970mr17640745pjb.44.1674584763138;
        Tue, 24 Jan 2023 10:26:03 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21c8::13fb? ([2620:10d:c090:400::5:69a5])
        by smtp.gmail.com with ESMTPSA id h8-20020a17090a054800b00226463cd239sm8736278pjf.15.2023.01.24.10.26.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 10:26:02 -0800 (PST)
Message-ID: <296fcfac-9acd-9462-871c-b450fd140fa3@gmail.com>
Date:   Tue, 24 Jan 2023 10:26:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Is fentry/fexit support possible with an external BTF?
Content-Language: en-US
To:     Jason Ling <jasonling@google.com>, bpf@vger.kernel.org
References: <CAHBbfcUkr6fTm2X9GNsFNqV75fTG=aBQXFx_8Ayk+4hk7heB-g@mail.gmail.com>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAHBbfcUkr6fTm2X9GNsFNqV75fTG=aBQXFx_8Ayk+4hk7heB-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/23/23 16:21, Jason Ling wrote:
> Some context:
>
> The devices I am interested in have a small kernel partition (~16MB).
> Building the kernel with CONFIG_DEBUG_INFO_BTF=y increases the kernel
> size by about ~1.7M.
> So I've tried to use an external BTF (generating my own vmlinux BTF
> and placing it on a more spacious partition) but it seems like my
> eBPFs that attach to fexit hooks now fail loading. According to some
> comments in libbpf this seems to be expected.
>
> e.g an eBPF program that looks like this
>
> SEC("fexit/ksys_unshare")
> int BPF_PROG(handle_exit, unsigned long unshare_flags, int rv) {
> }
>
> fails the loading process.
>
>
> My guess is that there is additional debug/BTF information beyond what
> is available in vmlinux BTF that gets linked into vmlinuz and without
> this information the attaching to certain hooks fail.

IIRC, the verifier running in the kernel also needs BTF to verify the code.

That means you need a way to load BTF to kernel manually as well.


>
> So my question is:
>
> is there a way to achieve my goal of using a kernel that has been
> built with CONFIG_DEBUG_INFO_BTF=n and still be able to use
> fentry/fexit type hooks?
