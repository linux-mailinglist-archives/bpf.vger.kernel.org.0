Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53D0B8BB43
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2019 16:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbfHMORl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Aug 2019 10:17:41 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40006 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728681AbfHMORk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Aug 2019 10:17:40 -0400
Received: by mail-qk1-f193.google.com with SMTP id s145so79766700qke.7
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2019 07:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D9XEkfdrTpRsDvLbOWM/kDfwV+anKwtzA9g2jyyYlc0=;
        b=Quig1zLNeY5xuaRIxfe0tjc6LVnb0hrDGootjTZ+PBtgVnHeTwbHz/UILdR+BgrUwe
         NDHZXoMcDjR83X+C8WHvRCSmLBSS/8j0eRn2MQKx+ZpwB/WGC4s7j3zjv4P8100tFKkc
         IKWP3I3jQVUOjGyNgMJuyywnCFxSrEoBQt5SrmCD0Xhn3pdTFG2wtAjtfUPqL+lzuWbn
         MpInW7wccRXCS/nrcUzhOjplZpegQnQoSlzmdiZ+ucHDCh4nqy5ocIkmygTGXuu4iyr8
         HXb0kJ4FbziPtzcJFB0VgUjwkyTKbBV755cq4rwWsVj+ls5fVypMYDl9IgDhU5HH9rVJ
         copw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D9XEkfdrTpRsDvLbOWM/kDfwV+anKwtzA9g2jyyYlc0=;
        b=SGFNzNLyJ5lDnxlgOlPQpCUVlYo+iSEXt1NtvoVh2pbZXz+hmnPjVtOdKn5r165M7A
         SHmLmAEd+sQvRud2ZDQhqJQOmB/0MdhSLi9YXkfp1p+GmE+swSHaYV3cyVZ2IHkruwqu
         UfKjy+e1DR2k/e3dRvpHTpuX0D/5f6ls7wSmoT/sG7U7KsHpOAhzshlwxIraxU+spFJN
         OYuR5oS0+roPm7+LGrG8kUQnu/R2H4o5BYwwySiTYCMTjg3iMI8BgeRpBAfCHtxa8/9G
         nuSiw1yUB7ZheW+9Z0n+u7PQ2y7tQOV1OLUohCldBArqb88HCpD35VtIi6+hcMCaeAOw
         E5mg==
X-Gm-Message-State: APjAAAWikMv2nAgBIMjTI7jfOcbC6LUCLHdVvCpsSZA3SvpeW+MXcX2d
        kV4ndv+42yjqJ21OgBmu8aQ=
X-Google-Smtp-Source: APXvYqxmwBE1f/MgxkVCMaXgO0JewaMMZZLCkSiZ0rI0XOIJOlZ5LKpHL1ugzIJFuHdfcXWXsQxmYg==
X-Received: by 2002:a37:83c4:: with SMTP id f187mr33317110qkd.380.1565705859814;
        Tue, 13 Aug 2019 07:17:39 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id k25sm60440539qta.78.2019.08.13.07.17.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 07:17:38 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 62C7040340; Tue, 13 Aug 2019 11:17:35 -0300 (-03)
Date:   Tue, 13 Aug 2019 11:17:35 -0300
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH v1] tools: Keep list of tools in alphabetical order
Message-ID: <20190813141735.GC12299@kernel.org>
References: <20190628172209.37290-1-andriy.shevchenko@linux.intel.com>
 <CAPhsuW75_wNSkLeRVL-X+qtdbExU+xcu7Vx5f5ZiH2CL-3TPxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW75_wNSkLeRVL-X+qtdbExU+xcu7Vx5f5ZiH2CL-3TPxA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Jun 28, 2019 at 10:53:27AM -0700, Song Liu escreveu:
> On Fri, Jun 28, 2019 at 10:23 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > When `make help` is executed it lists the possible tools to build,
> > though couple of entries is kept unordered. Fix it here.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Song Liu <songliubraving@fb.com>

Thanks, applied.

- Arnaldo
