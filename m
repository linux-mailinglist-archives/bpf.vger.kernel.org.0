Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6C4166C9E
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2020 03:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbgBUCGI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Feb 2020 21:06:08 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35969 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgBUCGH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Feb 2020 21:06:07 -0500
Received: by mail-pg1-f196.google.com with SMTP id d9so200046pgu.3
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2020 18:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o1r3IROrJ9LRxfw9e5YAVMX+zhTQvCAxTuDYKcYkZOs=;
        b=VYeVWuU6xxQmb5tIFON/WrL+cz1VhNgyAWy8OZ+RzOOs0rq2kgiNyWWxErCPNC5wEc
         a3iaD28SEOmWqeHYDczThnHqkMWkAO871GwoDeTnLWHasndVnp2XNZkFwuUnQ6cLPA7L
         /NhTuBxvG+x+Hge6rc+S4ZNh1IRP0U09SImAotSKxi0vwxqfKygk2WmVvln/llK2BDNG
         uYmd5hAslNihpLQIvoAfFW3ZG5P12fzYEtpXo9ImLI8HDc5789UDv53QkMSDwELLlFFG
         Haxlj+N/MVlXi+9uI1YI2ipQJDcji6LgOWsaxayNHGbaJahGxLpW+ic/btYNlKpruqex
         g3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o1r3IROrJ9LRxfw9e5YAVMX+zhTQvCAxTuDYKcYkZOs=;
        b=ZOMasfAoH/Kpb76mu2GV3koX00gd+ylLo3ywsZwBOobVBWF78wnui/6ArOB5Nywrlr
         HSBWXmmSrH432ut8WURyqODaSYP5YmqIygUKUVSUzJHmQGHU6xbKnyuj3lTcWTcN00r4
         LWmaIP2FRMJHLJK87ShuPAvGGzSHOmXehLws6VWj8xcwWcUn1NqiJ3osRCOylLTeg2ee
         IKcOszkXT+eMo8Bm6RTvb94VP8JuwXaApFk485psIZ9KJSvguocUg4XP5Wi0wBgw2Lnd
         nzs00aQyOODNHgCWFnfjh3jBcwiH1SdPewjgsBnZvyqr58a5/LHHMSEWJ/XqnhG4+OxC
         HIEg==
X-Gm-Message-State: APjAAAWWf3BuG8LQDyXgDmxi3MzLqD/8s8v7GTH/exo41bzlM4WHGcDs
        VGbBIPasM2qJ1sTUQ92RRng=
X-Google-Smtp-Source: APXvYqxg80Wp+HxQYE4p8mfkRaUubbNSjbzVH4g2TAfkyO99lKMvz24uN8nBKj+ehVqUKpyTmAOfLg==
X-Received: by 2002:a63:aa09:: with SMTP id e9mr36227093pgf.354.1582250765644;
        Thu, 20 Feb 2020 18:06:05 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:500::5:f03d])
        by smtp.gmail.com with ESMTPSA id e6sm866615pfh.32.2020.02.20.18.06.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Feb 2020 18:06:04 -0800 (PST)
Date:   Thu, 20 Feb 2020 18:06:03 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH bpf-next] docs/bpf: update bpf development Q/A file
Message-ID: <20200221020602.tetdzvwhuhhurjjh@ast-mbp>
References: <20200221004354.930952-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221004354.930952-1-yhs@fb.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 20, 2020 at 04:43:54PM -0800, Yonghong Song wrote:
> bpf now has its own mailing list bpf@vger.kernel.org.
> Update the bpf_devel_QA.rst file to reflect this.
> 
> Also llvm has switch to github with llvm and clang
> in the same repo https://github.com/llvm/llvm-project.git.
> Update the QA file with newer build instructions.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>

Applied, Thanks
