Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7FBDF871
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2019 01:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbfJUXQF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Oct 2019 19:16:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46916 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730276AbfJUXQE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Oct 2019 19:16:04 -0400
Received: by mail-pf1-f196.google.com with SMTP id q5so9368824pfg.13
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2019 16:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=SIazbGGrODWbrTu58S9RmN4EpuuCS7YJjAB2It/OA0k=;
        b=oHMv5HG1Ss7uQiQr0HZqS0JqLJqa6fUER36ipCFDLxHLr5wqqqBig5LpXYkdS6MhVE
         8+RHZ10Q/KdNvZ/NMkZDmuXOanyMRkwpMF3js+0LP2Zxob4BAsSN/Ey6Kq29NdwMB3LN
         8C2xdub6zuszZNLDjs9eu3crx9kpgd7yUflIIH160ThihJMPJ9DmBY70pNcm8unfl14y
         ++oi/35LtKt8bx4eM48LK6++0ZT14sstZGvuH757ZpXfBiUkma+GoV/kuhaYQe3k11sg
         WFUkYoElkLZwU21+jMvtZkpfIkVcdjh7EKoEYkG+9IioGUjnLXFOF09w6vUwjxOpeKmi
         PjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=SIazbGGrODWbrTu58S9RmN4EpuuCS7YJjAB2It/OA0k=;
        b=sx+6FhnxVZJYf8mCLvcP9+QY1avV2zp76ZazTvtaxGfEhnEDXEBiTgxSpAy5r+1kkn
         84neR+AQQ5ItN8ghj4Qi7s8zOCPTE4S8L9fhdAFop0ENuOkPzWztC6ui2iw6xsPVXrz2
         U0+zKJhSTsbGWrfaNUrdYWdlGzm9XTh9D956W/7qSL2ozwkQ4HQ5OCcug/mlcRXcZDVD
         RvNNdkYJJNiIe/BM+KdT1mot2d7HPSBTXh0dyLtxWEqe5cVLp7um3JDX22dv+x5P8rd9
         KFbuEvdg98PZMj4FLN1a2t1QzofwYAwhUTVBXAMk8AeuzorPUIil40JMV8iq4VbX7Xkt
         03gw==
X-Gm-Message-State: APjAAAW5nmz0/iqm//PY5RrM22qMsdOA4I3NFgAhEXglwAjjE8XyNCGM
        19n5s2QX/c3N+2BoIcabFiJIqQ==
X-Google-Smtp-Source: APXvYqwUupoLUquBzzVqMXRG2rPQmVWyjAJrS7NMYXMcTAUeIZu/lU/4IiVC3ni9FdOQFFk7rsfT1g==
X-Received: by 2002:a17:90a:a88e:: with SMTP id h14mr247045pjq.42.1571699763985;
        Mon, 21 Oct 2019 16:16:03 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id n2sm17412294pgg.77.2019.10.21.16.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 16:16:03 -0700 (PDT)
Date:   Mon, 21 Oct 2019 16:16:00 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>,
        Yonghong Song <yhs@fb.com>, Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCH] bpftool: Try to read btf as raw data if elf read fails
Message-ID: <20191021161600.282c04fb@cakuba.netronome.com>
In-Reply-To: <20191021140227.GD32718@krava>
References: <20191018103404.12999-1-jolsa@kernel.org>
        <20191018153905.600d7c8a@cakuba.netronome.com>
        <20191021140227.GD32718@krava>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 21 Oct 2019 16:02:27 +0200, Jiri Olsa wrote:
> > >  static int do_dump(int argc, char **argv)
> > >  {
> > >  	struct btf *btf = NULL;
> > > @@ -397,7 +429,7 @@ static int do_dump(int argc, char **argv)
> > >  	__u32 btf_id = -1;
> > >  	const char *src;
> > >  	int fd = -1;
> > > -	int err;
> > > +	int err = 0;  
> > 
> > This change looks unnecessary.  
> 
> I'm getting confusing warnings from gcc about this,
> but there is a code path where do_dump would return
> untouched err:
> 
>   do_dump
>      int err;
> 
>      } else if (is_prefix(src, "file")) {
>        btf = btf__parse_elf(*argv, NULL);   // succeeds
> 
>      }
> 
>      while (argc) {
>        if (is_prefix(*argv, "format")) {
>        else {                                // in here
>           goto done;
>        }
> 
>      done:
>        return err;

ugh, right those look legit, although unrelated to you change.

err should always be set before jumping to 'done'. The error
setting in this function looks super messy :( Sometimes is returns
errno codes, sometimes positive values, sometimes negative, sometimes
just -1. Sometimes it jumps to 'done' for no good reason, ahh :/
