Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5B72AF06C
	for <lists+bpf@lfdr.de>; Wed, 11 Nov 2020 13:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgKKMTv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Nov 2020 07:19:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:58360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgKKMTu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Nov 2020 07:19:50 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E05D206D9;
        Wed, 11 Nov 2020 12:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605097189;
        bh=//LhQnPW0ptpFibtoIdj4MpuoM0KfAYUqr+F5oyZ5u8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MEDDze7/uUjglHC3N+cR7/R/L94TSfSsqyhPLXjJuq71WToCPRrkm59+tmspRXHrQ
         xw84jDKmn34BAtsOlbNOLb2T+PNV8Xx1MX1ddf6Jq0AwFbDg4/7CyJGQWPSK9+oeMq
         nYlo4CfWYApgD+ZUa5WEvajoGlbVuOkVxuXe9K9g=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4205A411D1; Wed, 11 Nov 2020 09:19:46 -0300 (-03)
Date:   Wed, 11 Nov 2020 09:19:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH dwarves 4/4] btf: add support for split BTF loading and
 encoding
Message-ID: <20201111121946.GD355344@kernel.org>
References: <20201106052549.3782099-1-andrii@kernel.org>
 <20201106052549.3782099-5-andrii@kernel.org>
 <20201111115627.GB355344@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111115627.GB355344@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Nov 11, 2020 at 08:56:27AM -0300, Arnaldo Carvalho de Melo escreveu:
> 
> The entry for btf_encode/-J is missing, I'll add in a followup patch.
> 
> Also I had to fixup ARGP_btf_base to 321 as I added this, to simplify
> the kernel scripts and Makefiles:
> 
>   $ pahole --numeric_version
>   118
>   $

Added this:

[acme@five pahole]$ git diff
diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index 20ee91fc911d4b39..f44c649924383a32 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -181,6 +181,14 @@ the debugging information.
 .B \-\-skip_encoding_btf_vars
 Do not encode VARs in BTF.

+.TP
+.B \-J, \-\-btf_encode
+Encode BTF information from DWARF, used in the Linux kernel build process when
+CONFIG_DEBUG_INFO_BTF=y is present, introduced in Linux v5.2. Used to implement
+features such as BPF CO-RE (Compile Once - Run Everywhere).
+
+See \fIhttp://vger.kernel.org/bpfconf2019_talks/bpf-core.pdf\fR.
+
 .TP
 .B \-\-btf_encode_force
 Ignore those symbols found invalid when encoding BTF.
[acme@five pahole]$
