Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE7D29A2DD
	for <lists+bpf@lfdr.de>; Tue, 27 Oct 2020 03:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409718AbgJ0C7D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Oct 2020 22:59:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23615 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409605AbgJ0C7D (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 26 Oct 2020 22:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603767540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j/zuX56M6lwTf/n0BJ4lchxCW07b2NAAyGDnkjNpYxM=;
        b=IWkIy03HF9ksSJ8iPxhJf1/I/685vp2kvz/lSTyzVMoLZ6rnsLb3KrFaV/3peM9MrRqP1+
        rnKreHwauecBymbjfuUMNbkRLFKoAC6UK8aLXQg7DNhRwhBenbtKSdGkNegojtcXm+iz5c
        z0iDFFkdV6v+lAGAJivqtJkN+C1rwJ0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-akRJz_vFNHSGEzWT0gg36Q-1; Mon, 26 Oct 2020 22:58:59 -0400
X-MC-Unique: akRJz_vFNHSGEzWT0gg36Q-1
Received: by mail-pl1-f198.google.com with SMTP id u14so86559plq.5
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2020 19:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j/zuX56M6lwTf/n0BJ4lchxCW07b2NAAyGDnkjNpYxM=;
        b=tq7JHzJsG+IoXyK0UlOtkKO+d8htwvYmDxyhyea3di3JgkCWzlPiWSsmIl6Nsk7GIP
         K/X2YXTSXCRtSmUpidWNb9+AgwFgfQcXbcDBl78YLUzJBVOvjz3ZZTuki6i2oQjRqKp5
         WZeu3JonSet9eTzS25NanC5x/rYNMdwdKQ0W6130648BWNFaUHYLMPmEFX/1PkKu88o2
         iaJRzyfj/0d+hez32ea27zdsqkMsLaE+LOEGtZUp9DP9tlqxS0jlhBoeR6oFdG8euHYW
         Mjg/YXQ6VUTWoRv5cyQaBxrW/NRyleNdT4OXac64cIghh+tsbsDqKPdHlqWoCg277gFu
         08JQ==
X-Gm-Message-State: AOAM530sGDLt1V+y55/MPDHTxER7BG/svIPgPLcQ+GdBhZy8HI7FMQRb
        k5kbcjt8DzI0GwpDqtOwIhTZLy61HOFJDVYni6mJQtUXc2zoL4Qx0M9Aj0TW0pTVmdsn5EqSK+W
        FFUBBBww30xA=
X-Received: by 2002:a17:90a:6901:: with SMTP id r1mr47449pjj.178.1603767537590;
        Mon, 26 Oct 2020 19:58:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqkkb3uDiz8D374HN4hGt0a9woJy07RNjW4K1LFkKLNyKAPot3CcJXpRwYzK2UXxCAW6QC0A==
X-Received: by 2002:a17:90a:6901:: with SMTP id r1mr47418pjj.178.1603767537264;
        Mon, 26 Oct 2020 19:58:57 -0700 (PDT)
Received: from dhcp-12-153.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s38sm3910898pgm.62.2020.10.26.19.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 19:58:56 -0700 (PDT)
Date:   Tue, 27 Oct 2020 10:58:45 +0800
From:   Hangbin Liu <haliu@redhat.com>
To:     David Ahern <dsahern@gmail.com>
Cc:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH iproute2-next 3/5] lib: add libbpf support
Message-ID: <20201027025845.GI2408@dhcp-12-153.nay.redhat.com>
References: <20201023033855.3894509-1-haliu@redhat.com>
 <20201023033855.3894509-4-haliu@redhat.com>
 <29c13bd0-d2f6-b914-775c-2d90270f86d4@gmail.com>
 <87eelm5ofg.fsf@toke.dk>
 <91aed9d1-d550-cf6c-d8bb-e6737d0740e0@gmail.com>
 <20201026085610.GE2408@dhcp-12-153.nay.redhat.com>
 <063cb81c-a1b7-3893-792e-280adb6a0f33@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <063cb81c-a1b7-3893-792e-280adb6a0f33@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 26, 2020 at 09:15:00AM -0600, David Ahern wrote:
> >> actually, it already does: bpf_load_program
> > 
> > Thanks for this info. Do you want to convert ipvrf.c to:
> > 
> > @@ -256,8 +262,13 @@ static int prog_load(int idx)
> >  		BPF_EXIT_INSN(),
> >  	};
> >  
> > +#ifdef HAVE_LIBBPF
> > +	return bpf_load_program(BPF_PROG_TYPE_CGROUP_SOCK, prog, sizeof(prog),
> > +				"GPL", 0, bpf_log_buf, sizeof(bpf_log_buf));
> > +#else
> >  	return bpf_prog_load_buf(BPF_PROG_TYPE_CGROUP_SOCK, prog, sizeof(prog),
> >  			         "GPL", bpf_log_buf, sizeof(bpf_log_buf));
> > +#endif
> >  }
> >  
> >  static int vrf_configure_cgroup(const char *path, int ifindex)
> > @@ -288,7 +299,11 @@ static int vrf_configure_cgroup(const char *path, int ifindex)
> >  		goto out;
> >  	}
> >  
> > +#ifdef HAVE_LIBBPF
> > +	if (bpf_prog_attach(prog_fd, cg_fd, BPF_CGROUP_INET_SOCK_CREATE, 0)) {
> > +#else
> >  	if (bpf_prog_attach_fd(prog_fd, cg_fd, BPF_CGROUP_INET_SOCK_CREATE)) {
> > +#endif
> >  		fprintf(stderr, "Failed to attach prog to cgroup: '%s'\n",
> >  			strerror(errno));
> >  		goto out;
> > 
> 
> works for me. The rename in patch 2 can be dropped as well correct?
> 

No, the BPF_MOV64_* micros are not defined in uapi, so we still need include
"bpf_util.h", which will got bpf_prog_load() conflicts.

Thanks
Hangbin

