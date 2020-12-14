Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B852D9935
	for <lists+bpf@lfdr.de>; Mon, 14 Dec 2020 14:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438166AbgLNNsI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Dec 2020 08:48:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:38284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406099AbgLNNoM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Dec 2020 08:44:12 -0500
Date:   Mon, 14 Dec 2020 10:43:43 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607953411;
        bh=7H1l/OZXZjWrQ4sxxJQS8JEP7T6y9WpDSART6dvQ+ec=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dt3ebbQmuaupJqAtbUX9FNX4haD7prTtABSBFu6mzjI8iVMjT0wPi4zyF1b2zQ/4a
         bsiTmFZF1e9Km+/bM65wG3tJRTKXvlkXuf8lv8xq7APMH71xGeOUmGig4WgxlqMdwX
         WNJaK8WN4c0LrRAstBNE9V/qgj94HW63E99gbSXZy9RMQlRn85uEimBwCOw1MONaJD
         clEgEYCgwtsSxjwRCwljRqJ0YNsicAO+Pff4u4jmNDKVuBXSAWhC7KK8rkupmVqY96
         ZAB0kZgIOhuFDl1XlC9RpuJVJ17PHJ5UtNJux+aZ15JX5kKBXCKmI3x3CRi1GHvA9C
         YDS9Ezg3tPycA==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH dwarves 0/2] Fix pahole to emit kernel module BTF
 variables
Message-ID: <20201214134343.GF238399@kernel.org>
References: <20201211041139.589692-1-andrii@kernel.org>
 <20201213202757.GA482741@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201213202757.GA482741@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Sun, Dec 13, 2020 at 09:27:57PM +0100, Jiri Olsa escreveu:
> On Thu, Dec 10, 2020 at 08:11:36PM -0800, Andrii Nakryiko wrote:
> > Two bug fixes to make pahole emit correct kernel module BTF variable
> > information.
> > 
> > Cc: Hao Luo <haoluo@google.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > 
> > Andrii Nakryiko (2):
> >   btf_encoder: fix BTF variable generation for kernel modules
> >   btf_encoder: fix skipping per-CPU variables at offset 0
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

