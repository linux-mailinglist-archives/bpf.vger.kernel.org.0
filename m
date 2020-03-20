Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC7CE18DA75
	for <lists+bpf@lfdr.de>; Fri, 20 Mar 2020 22:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgCTVdT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Mar 2020 17:33:19 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35693 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCTVdT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Mar 2020 17:33:19 -0400
Received: by mail-pl1-f196.google.com with SMTP id g6so3059825plt.2
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2020 14:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TU2T6ZpLINjsN0NPDwk9LFYRhL6nv6T9Pj1rk4Fvgws=;
        b=ZngJrysM1xXorW7zcL8RRdLTgvsh8baMVjy2WjSb3Tlqu3Y3WfBqYiJxkPtGhlwMFw
         gcyG9gv/4jqR3qsXlAvzSdy1kx1VguJoz+6LdMZruz9WvUfBeYGWTzPWCA4RG6MCsPXz
         Wdr7Y1jqdfClPrw6c4o5qc/Wv3nxDkSGyt4tmLYUFD3Io8xrUOuBcc53VuFkjvNE4lqA
         iUGTKSlcz/f1ZUV52bt3+NjUCU1j/f2Yx+hPQYKu8HEaCq7juNap2mF4V66DtaY//wZQ
         ePx0srok7JGhH/Y6W8PToAW63KED8yNX6MDZHWePdBMNbrXWGxsnaen7Kh1wQzuwb7ux
         RHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TU2T6ZpLINjsN0NPDwk9LFYRhL6nv6T9Pj1rk4Fvgws=;
        b=GdQV0K4dYahXw/onkknnj7wmzANrbgwH9scFraDdhDmNPqA9RzeTqs4+SjhQTkkHj6
         OhNL4FuqXVt+tTTb/m32HWEg0363vpgIUL+07FSVbf+fDDFNXiu03hONAyD1GPU1a/66
         6FdSOjMjL/5HMkG5nYzTfPN+ib/03Rxek42wD6uJZkWeGFwPTE0/WLZUUgZtXZ3zjC9H
         0NTtMo/FaTxvIyl+ei5D1zAbHSPFoq7x5tOvBq+xgbL1hn5bWv0MG8EMEl3wn11RkKR/
         bavaVWMMiE/xxa0WDLuVLHk6zzPKKu6kyoFtnQdUUC+N/CnXjyq+52KaJANJG15wDHNY
         yLUg==
X-Gm-Message-State: ANhLgQ22iIsVauUqJtnEBzhMDKH2knKk1JlUG/wCP8eFp8lzdceaKa01
        gaJnbR/YC2HSpj5V/04ZsGvqZQ==
X-Google-Smtp-Source: ADFU+vvnWAei4cQJJYAi95fr3AY6Ha6YpQA+nmxexdMSFSnYsOJojq6pn1eKeR48kRER+fOR67vbGQ==
X-Received: by 2002:a17:902:8a81:: with SMTP id p1mr10353607plo.284.1584739997755;
        Fri, 20 Mar 2020 14:33:17 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id l67sm5756255pjb.23.2020.03.20.14.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 14:33:17 -0700 (PDT)
Date:   Fri, 20 Mar 2020 14:33:16 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com,
        daniel@iogearbox.net, andrii.nakryiko@gmail.com, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 3/6] bpf: implement bpf_link-based cgroup BPF
 program attachment
Message-ID: <20200320213316.GA2708166@mini-arch.hsd1.ca.comcast.net>
References: <20200320203615.1519013-1-andriin@fb.com>
 <20200320203615.1519013-4-andriin@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320203615.1519013-4-andriin@fb.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/20, Andrii Nakryiko wrote:
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 5d01c5c7e598..fad9f79bb8f1 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -111,6 +111,7 @@ enum bpf_cmd {
>  	BPF_MAP_LOOKUP_AND_DELETE_BATCH,
>  	BPF_MAP_UPDATE_BATCH,
>  	BPF_MAP_DELETE_BATCH,
[..]
> +	BPF_LINK_CREATE,
Curious, why did you decide to add new command versus reusing existing
BPF_PROG_ATTACH/BPF_PROG_DETACH pair? Can we have a new flag like
BPF_F_NOT_OWNED that we can set when calling BPF_PROG_ATTACH to trigger
all these new bpf_link properties (like cgroup not holding an extra ref)?
