Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9571B7207
	for <lists+bpf@lfdr.de>; Fri, 24 Apr 2020 12:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgDXKcL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Apr 2020 06:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbgDXKcK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Apr 2020 06:32:10 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41819C09B045
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2020 03:32:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id i10so10143470wrv.10
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2020 03:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DuL/FnB2qQTF/BcV+/SmiUjtSwdbN0dYeuA3t4WT6Co=;
        b=yVxvPQx9pXdyT/LBWCxfIVNFBTViFRKoy5zR8STitTUxEAIiM8wtnHH0vjXS4te3Hx
         E3zi0seWrr1/fK4mukK0yKTIkCsY3rHuub6kTlQb6yNtrRXl2kPJvBlGa1NllzsL8xI+
         PtHUa4+QVFROfEqtwTHrwYMNj3f1B7uPbnEIb8bxGnNLQCirKMBL0ACXpRIqKyH+9EHH
         HIU/DL6e+vG0ehCMOqB/7DxkGlNa7jgVzyCdGkRi/pRgcV7kv30wjBz5JT1IX0SD1Hu2
         b8UdK3B8A4tQCzSZ+JbICZzJbjHKw+ZSjEpkhd1+qsoYbaAFOUkOGIdLZ+YSqbfq9QCc
         7dFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DuL/FnB2qQTF/BcV+/SmiUjtSwdbN0dYeuA3t4WT6Co=;
        b=Dqt2Ir9gzm0h0/gJc0CIlgqhcWBx7Cn6H4VYu6FucG3p0KPXhLxn1G/tw1vnojYSCK
         MW1p+VKYSNGnYlOMpQMmdK7+fLY4A7gHbw/W4hJujVCzs6MLY2AXH1dnDMQGY77/jjpn
         d5+X9uifY3OpU6ZoFU5rsZN65Eh18OHxazlviFaCYHdOou21ltltSakSZYVURTA0+uBJ
         WNXVIjzSgiudwCHQVtOF5bU/B88j/pvETXBv/hwusMYcAFsE4Qe5JGvinpaNq7aI/sx5
         em+E+iNXP1I50iG8cCKxXqH3htfrSwradu8wDRQswAlE6ezVR2UurWolnhCbiJMub1sr
         ghhA==
X-Gm-Message-State: AGi0PuahLBobQI3f9XnCzSQ6lpv4J89K+A5xFd5u1ZI/u9sql3otz2op
        MOXJ0Z+CTRtbqjDY0+T23bwVaA==
X-Google-Smtp-Source: APiQypLOZcmRrkKClt02n+pliNll9PVQ+Giu+6P0fQjVPw+L/z7ivJ5XUAjija28I30NHQvRg+Vj8w==
X-Received: by 2002:a5d:6850:: with SMTP id o16mr9978981wrw.309.1587724328981;
        Fri, 24 Apr 2020 03:32:08 -0700 (PDT)
Received: from [192.168.1.10] ([194.53.185.129])
        by smtp.gmail.com with ESMTPSA id i17sm7675624wru.39.2020.04.24.03.32.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 03:32:08 -0700 (PDT)
Subject: Re: [PATCH bpf-next 07/10] bpftool: expose attach_type-to-string
 array to non-cgroup code
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com, daniel@iogearbox.net
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com
References: <20200424053505.4111226-1-andriin@fb.com>
 <20200424053505.4111226-8-andriin@fb.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <34110254-6384-153f-af39-d5f9f3a50acb@isovalent.com>
Date:   Fri, 24 Apr 2020 11:32:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424053505.4111226-8-andriin@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-04-23 22:35 UTC-0700 ~ Andrii Nakryiko <andriin@fb.com>
> Move attach_type_strings into main.h for access in non-cgroup code.
> bpf_attach_type is used for non-cgroup attach types quite widely now. So also
> complete missing string translations for non-cgroup attach types.
> 
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  tools/bpf/bpftool/cgroup.c | 28 +++-------------------------
>  tools/bpf/bpftool/main.h   | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 25 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
> index 62c6a1d7cd18..d1fd9c9f2690 100644
> --- a/tools/bpf/bpftool/cgroup.c
> +++ b/tools/bpf/bpftool/cgroup.c
> @@ -31,35 +31,13 @@
>  
>  static unsigned int query_flags;
>  
> -static const char * const attach_type_strings[] = {
> -	[BPF_CGROUP_INET_INGRESS] = "ingress",
> -	[BPF_CGROUP_INET_EGRESS] = "egress",
> -	[BPF_CGROUP_INET_SOCK_CREATE] = "sock_create",
> -	[BPF_CGROUP_SOCK_OPS] = "sock_ops",
> -	[BPF_CGROUP_DEVICE] = "device",
> -	[BPF_CGROUP_INET4_BIND] = "bind4",
> -	[BPF_CGROUP_INET6_BIND] = "bind6",
> -	[BPF_CGROUP_INET4_CONNECT] = "connect4",
> -	[BPF_CGROUP_INET6_CONNECT] = "connect6",
> -	[BPF_CGROUP_INET4_POST_BIND] = "post_bind4",
> -	[BPF_CGROUP_INET6_POST_BIND] = "post_bind6",
> -	[BPF_CGROUP_UDP4_SENDMSG] = "sendmsg4",
> -	[BPF_CGROUP_UDP6_SENDMSG] = "sendmsg6",
> -	[BPF_CGROUP_SYSCTL] = "sysctl",
> -	[BPF_CGROUP_UDP4_RECVMSG] = "recvmsg4",
> -	[BPF_CGROUP_UDP6_RECVMSG] = "recvmsg6",
> -	[BPF_CGROUP_GETSOCKOPT] = "getsockopt",
> -	[BPF_CGROUP_SETSOCKOPT] = "setsockopt",
> -	[__MAX_BPF_ATTACH_TYPE] = NULL,

So you removed the "[__MAX_BPF_ATTACH_TYPE] = NULL" from the new array,
if I understand correctly this is because all attach type enum members
are now in the new attach_type_name[] so we're safe by looping until we
reach __MAX_BPF_ATTACH_TYPE. Sounds good in theory but...

> -};
> -
>  static enum bpf_attach_type parse_attach_type(const char *str)
>  {
>  	enum bpf_attach_type type;
>  
>  	for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++) {
> -		if (attach_type_strings[type] &&
> -		    is_prefix(str, attach_type_strings[type]))
> +		if (attach_type_name[type] &&
> +		    is_prefix(str, attach_type_name[type]))
>  			return type;
>  	}

... I'm concerned the "attach_type_name[type]" here could segfault if we
add a new attach type to the kernel, but don't report it immediately to
bpftool's array.

Is there any drawback with keeping the "[__MAX_BPF_ATTACH_TYPE] = NULL"?
Or change here to loop on ARRAY_SIZE(), as you do in your own patch for
link?
