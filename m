Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8874FDBD46
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2019 07:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391955AbfJRFyu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Oct 2019 01:54:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37763 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfJRFyu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Oct 2019 01:54:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id p1so2735088pgi.4
        for <bpf@vger.kernel.org>; Thu, 17 Oct 2019 22:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O64k64LFwOm51ZSh8xkoD1TCVFNCTSCla81D5pSJ7kw=;
        b=XZ3mjYmCEMuMa2vmopUKHKPKXqQcrSlMRexjLnfWoaWYV7KsE0DHJ3TZyovBqopaxN
         dyvF/McWfSNbORm39kBOBJB6o0sPlatc9XXFCIPRgcpqFHeiQu9DC4ypYTyjz7DP6Zl4
         27X6AmzkQXCVy4Og4vZXta8Kr+9nRemz9g0kmmot5DLJsIf5N2Gmq7RHK0qVTpx7VHco
         DTdlyaKGu50zpJ0S2hlcg0wRFQSJmHrfVwqCvOES5pHi+GN7NdMKh/xWj+/djnYLvj+C
         qpqdK+UKUNWYLR7Yvfw/3AZt88NyA3fYVYDnQLe4ApjZymp/uhvmR3iNaozjxJ0eWaHx
         Tv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O64k64LFwOm51ZSh8xkoD1TCVFNCTSCla81D5pSJ7kw=;
        b=UICfmTKPNbyoPfj5zOCZnIl0mCdFDCeZb94RC9TDeeincfaF9DKkRDKFNDfeMtZe83
         AND0pIakgW5PyRygFfsF7/18ZzpKdo8TW76sO5d4YfDV1SAiLrjI/U4DUBz1ppoQmHez
         vQ4gSkDLI78q7oUovp7g8yzMYXi+9uULOKjt0J5lUgDF4G84n3uz9Zjdu6An4iOtO7+1
         2QJR4p96dvymB1g/VF/ftgaJunirPI0K/EDyeV8uUOTebyr1iy/Qi2LxD+QqeYVatsyz
         eBmgzKccuoL01NEBA1SiQgwGYt8qAiKNOu+U8jpBBlf39PgQGscNudWoNr5uw8RnZ0fZ
         54XA==
X-Gm-Message-State: APjAAAUtwlR23KdTnF220TblZeJn1iknyw8WqD2Rt7rTyI6Z4/M54Ikz
        vjpIO8iheI2ZIERi1RpY5AM=
X-Google-Smtp-Source: APXvYqwGoOzI2HEUfmjzn/oM+s/j3UivCjqY4aPk+FPhrvreB9pgZclNsdKlVhOPDAER3GN4fx1vSQ==
X-Received: by 2002:a63:6782:: with SMTP id b124mr8649462pgc.220.1571378089797;
        Thu, 17 Oct 2019 22:54:49 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:180::cfd0])
        by smtp.gmail.com with ESMTPSA id s14sm4242415pfe.52.2019.10.17.22.54.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 22:54:48 -0700 (PDT)
Date:   Thu, 17 Oct 2019 22:54:47 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     David Miller <davem@davemloft.net>
Cc:     williams@redhat.com, tglx@linutronix.de, bigeasy@linutronix.de,
        daniel@iogearbox.net, bpf@vger.kernel.org, ast@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        peterz@infradead.org, acme@redhat.com
Subject: Re: [PATCH] BPF: Disable on PREEMPT_RT
Message-ID: <20191018055445.wpesq2xmeu7v6ysg@ast-mbp>
References: <20191017.132548.2120028117307856274.davem@davemloft.net>
 <alpine.DEB.2.21.1910172342090.1869@nanos.tec.linutronix.de>
 <20191017214917.18911f58@tagon>
 <20191017.215739.1133924746697268824.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017.215739.1133924746697268824.davem@davemloft.net>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 17, 2019 at 09:57:39PM -0700, David Miller wrote:
> From: Clark Williams <williams@redhat.com>
> Date: Thu, 17 Oct 2019 21:49:17 -0500
> 
> > BPF programs cannot loop and are limited to 4096 instructions.
> 
> The limit was increased to 1 million not too long ago.

Right.
And it's easy to limit to 100 instructions per program for PREEMPT_RT.
I doubt it's necessary.

