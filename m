Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E4920264E
	for <lists+bpf@lfdr.de>; Sat, 20 Jun 2020 22:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgFTUHH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Jun 2020 16:07:07 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:45691 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728665AbgFTUHH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Jun 2020 16:07:07 -0400
Received: by mail-il1-f195.google.com with SMTP id 9so12526003ilg.12
        for <bpf@vger.kernel.org>; Sat, 20 Jun 2020 13:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pallissard.net; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2gNMr1S/xIykhwvOgtv8/8rjXyrli61zWUkcTHzpKvU=;
        b=WaV1CCeAOfGcm9IuM/Rcn8FYRtQTIdy4XeqG7yFirIXiXGOWl5qEjSPFy6RRczOJuz
         88QMNvFp8/Dtj3FT+8X7j8CP46q6sB1MiRvrj+FLRmQNNYaAuC+e8Lq0Dk7plbUEafKK
         dx5bH/w+wplddxLOfCtrzxgaEKNIxWk6qEbgiULCr3rl5tp5cNbYz0ZUvgJ38lhPqI+i
         rkjvlth/F4WpfYUZOXXSOWJfit5TTJr4ZjOPRBT4Ewtq8lH4hEu29wPH2brYubHt/jT8
         b5ncMFMm+wFoXm6Tvs82DE+mPQgfAHltMBkDh0eZdxAtm4xiQM7D+TAQR3UudV525oeu
         7xrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2gNMr1S/xIykhwvOgtv8/8rjXyrli61zWUkcTHzpKvU=;
        b=YJm3UY36SLVzs91aFliYZZX/A9YW84+vN5DJL2cR5KbP1g7t7MObCbTY3GKCIxiwXJ
         y21M8i3QxYzyM/83iqd7y/e0JIBADDA8slayHQJFsrisqertwaP5VFHMkcaK62OawJwT
         B1f6YiLDzccJxKVInEge0dJjK2nZusul8I64bsOyI77r/Ljvcpq7Mc9vUBgUbLWqwpA8
         1mhKdvSmi3t28gUrKKSu2LszQtdeulfi8Olk+3R0GGQIPnghb9l5lN4/dGiNW8WX5meE
         wvq7eebv7EIWqlTXLNslk/VK81HYj0LQ3QMVYAWJqvtVDlb7R68qe1QYhb/WUmcskqwx
         zp+w==
X-Gm-Message-State: AOAM532tZUHeB2bDqaDED0AHCI6l4HZgU1lsfZyZbo5uYyc6EFGD1ipa
        KgOXvW1tiho3r7XOTW58i2LwMQ==
X-Google-Smtp-Source: ABdhPJwROj7DasB8wnmYqcZOxsZxp4sSX7dZNMoiPXqrA4txHVoXSKGeeQ3Dn05qd9I9+pUkU35LJA==
X-Received: by 2002:a05:6e02:605:: with SMTP id t5mr9982030ils.231.1592683566141;
        Sat, 20 Jun 2020 13:06:06 -0700 (PDT)
Received: from mail.matt.pallissard.net (223.91.188.35.bc.googleusercontent.com. [35.188.91.223])
        by smtp.gmail.com with ESMTPSA id s190sm986216ilc.28.2020.06.20.13.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 13:06:05 -0700 (PDT)
Date:   Sat, 20 Jun 2020 13:06:02 -0700
From:   Matt Pallissard <matt@pallissard.net>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org
Subject: Re: Accessing mm_rss_stat fields with btf/BPF_CORE_READ_INTO
Message-ID: <20200620200602.ax7tjx5jrtgyj6vs@matt-gen-laptop-p01>
References: <20200620162216.2ioyj6uzlpc45jzx@matt-gen-desktop-p01.matt.pallissard.net>
 <4889d766-578e-1e20-119f-9f97621e766f@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4889d766-578e-1e20-119f-9f97621e766f@fb.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org




On 2020-06-20T11:11:55 -0700, Yonghong Song wrote:
>
>
> On 6/20/20 9:22 AM, Matt Pallissard wrote:
> > New to bpf here.
> >
> > I'm trying to read values out of of mm_struct.  I have code like this;
> >
> > unsigned long i[10] = {};
> > struct task_struct *t;
> > struct mm_rss_stat *rss;
> >
> > t = (struct task_struct *)bpf_get_current_task();
> > BPF_CORE_READ_INTO(&rss, t, mm, rss_stat);
> > BPF_CORE_READ_INTO(i, rss, count);
> >
> > However, all values in `i` appear to be 0 (i[MM_FILEPAGES], etc), as if no data gets copied.  I'm about 100% confident that this is caused by a glaring oversight on my part.
>
> Maybe you want to check the return value of BPF_CORE_READ_INTO.
> Underlying it is using bpf_probe_read and bpf_probe_read may fail e.g., due
> to major fault.

Doh, I should have known to check the return codes!  Yes, it was failing.  I knew I was overlooking something trivial.

Thanks a bunch.

Matt Pallissard
