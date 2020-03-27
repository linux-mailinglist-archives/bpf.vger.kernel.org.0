Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A77D1958EA
	for <lists+bpf@lfdr.de>; Fri, 27 Mar 2020 15:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgC0O0S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Mar 2020 10:26:18 -0400
Received: from mail-il1-f177.google.com ([209.85.166.177]:43391 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgC0O0S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Mar 2020 10:26:18 -0400
Received: by mail-il1-f177.google.com with SMTP id g15so8875489ilj.10
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2020 07:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Oii4TAjFFw2Hmj832hEAobNWUE/N1jm1qkzOSIs++rA=;
        b=Xn8tPPrwZbmVuZnlCEKgK6ZkNuOjxusDl0QhKOGO3nmU/qhHvdrxuSipBIJjR/wERO
         NV6pli5A+K0v7gzUoPcbBBoRwayLR0eGxTrFYBb5bKqVElt+1BgqZbpEFQtE4MWicM+m
         V69KRADh29CAYJiP5hnpjcwLmVxtbB8zK3FbKtTprliL9RANBA3O9ur5wKvQx62dFAzE
         B9bpF/iz50+/MsQPPMeWEZIkKSs7syySBZsq1dQGKhG3s9exsKY2eIMi6hM5bFNtjcR2
         txJxfV9cZZW9gT6U0rL6lZ3SVYBa7jobeY3VloqQRyAOS2E2++abQPwsPNhuerXNGzJx
         u4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Oii4TAjFFw2Hmj832hEAobNWUE/N1jm1qkzOSIs++rA=;
        b=eK8H3qS9ezxudwPs7NwCrFKJ9aGwKvtGQd0n5SS+y2jpnoMDfTk+54hxvy0B68TiAC
         vL8uWcqHKn6YR6Ao+XyDxMREAg1G59J/NXLAHDRF2qH0p24G/dT/bYgeB7II7o26lDi8
         bWuz9lcLt5yWtnOk7j1m1facB2o4zMcYgecqwHilmN1e1t1cC9mAUxlFDWgwQY8E0Ao/
         ldjxKseFK/88j0XcWy+G6hrNzH9xIlWB5VeoCma9OuQppy29bERUwMhRpeke/70fUVmf
         SQLH5yQ9L+behmj6oMKeMNiG04q8j8Xyenp4IisnLpHlmh3u/OGyVp/76n17ONuHF/gl
         OUSA==
X-Gm-Message-State: ANhLgQ32SNxzbcTIhS84JyVNwUR1BRe4grb8ZUz3ihIt2UWT0XMP3bZ/
        R4RIPaBOS4tQn7gr/j11o9Kq+g==
X-Google-Smtp-Source: ADFU+vuGCSzhcUGz0UoOTjCPF0X/6CR8eBY+wR+v1ejFXt9FuheU9eYWGFzfrX8XGUSWJnN1X+Q+hQ==
X-Received: by 2002:a92:a192:: with SMTP id b18mr13974595ill.199.1585319177493;
        Fri, 27 Mar 2020 07:26:17 -0700 (PDT)
Received: from [10.0.0.125] (23-233-27-60.cpe.pppoe.ca. [23.233.27.60])
        by smtp.googlemail.com with ESMTPSA id h15sm1581013ior.20.2020.03.27.07.26.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 07:26:17 -0700 (PDT)
Subject: Re: [PATCHv3 bpf-next 3/5] bpf: Don't refcount LISTEN sockets in
 sk_assign()
To:     Joe Stringer <joe@wand.net.nz>, bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org,
        eric.dumazet@gmail.com, lmb@cloudflare.com, kafai@fb.com
References: <20200327042556.11560-1-joe@wand.net.nz>
 <20200327042556.11560-4-joe@wand.net.nz>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Message-ID: <daf11ebd-e578-10d4-6e4a-00bb396258cf@mojatatu.com>
Date:   Fri, 27 Mar 2020 10:26:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200327042556.11560-4-joe@wand.net.nz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2020-03-27 12:25 a.m., Joe Stringer wrote:
> BPF_CALL_1(bpf_sk_release, struct sock *, sk)
>   {
> -	/* Only full sockets have sk->sk_flags. */
> -	if (!sk_fullsock(sk) || !sock_flag(sk, SOCK_RCU_FREE))
> +	if (sk_is_refcounted(sk))
>   		sock_gen_put(sk);
>   	return 0;
>   }


Would it make sense to have both the bpf_sk_release and bpf_sk_assign()
centralized so we dont replicate the functionality in tc? Reduces
maintainance overhead.

Thanks for working on this!

cheers,
jamal
