Return-Path: <bpf+bounces-37780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390DD95A7D9
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 00:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 643A1B2277B
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 22:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7189717BB0C;
	Wed, 21 Aug 2024 22:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgkV9Cpq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9C614B96A
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 22:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724279566; cv=none; b=kuvvwIThimC4QsdbLWiZeS6cYk2Lg3ftGKT/vOH3nz0mX9tF7itwovKPZTAyRepeik/Nz2zXwyeP/U39P0Mr4Vt1AfdOhSVorntJSRPSwH+lu0eNG6r9JsyuGTlFM8FF1jGwQ89PQUzWHAyvBqhuYbA6jUp7i9X+OBE6aNGDqNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724279566; c=relaxed/simple;
	bh=PF11EdQr2Lh4uBgZp4meRajs9z9//JgqL+NPKs842DM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZWOUOEfCKv0GN74LIYMt+zKaU0vklEZzOi8iXt8gViv0bc9mZwrw1vjiMSOWF9sL8IJ1jisEq0nklqcfTVkjeAc/aRlU+g0T/s+UmNhDshr48hFG5w5lxHtoNXNZd+EiGUUrUCFEM7LNuqLu80d4mMJYK4FBbc/zcUBu2HWSkkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgkV9Cpq; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-714187df604so828807b3a.1
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 15:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724279564; x=1724884364; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DIkn5TTTf5LEvLRbXdPPxhfhD8tpvdoNYD6mzbt3q4s=;
        b=VgkV9CpqFjZi2Th+s5yv3r4kRiOou1nWdJxHcFAr67e7qUu3I5FKmMXrO8Xlhrft7T
         mhHDeE6xazNKEqxSvoLV4l6V6vnxCg9r3S8Do+iRe6Ghmsg7O5YyAUwhAB9LyJbg3Nok
         82Ma2APPVWCnVOvVpYYxvX45WsIBc7A1/VIwHZz4zucP9e093YvXO/Ga9iwDmNk9zOwB
         u9AeBvxf9xz4v84Gv4e4dWPa3JdmDFVu5j4wODAjaxIMAEaiJ/9G+TOLTzotd6ZvhdxT
         k6tlk1T80D5DNKBAv0t2YMUngxzkHovmF+k2HVZiOBbw6/DLZzb0HG0YKHB2vsqD6aLc
         P1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724279564; x=1724884364;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DIkn5TTTf5LEvLRbXdPPxhfhD8tpvdoNYD6mzbt3q4s=;
        b=wzcu8s0l/LuMx/1sDCFQde3C9sRqYjHY/cBzlR5aqr+YUnBoSMERsVrb2s1rUNi2uQ
         WBnlMSoU/eyZNjxGL8pD0+ycICxs4c5i+51L2Ox3ikeYWkPx+VPnF0mE8LztbgnTBXlb
         I52CbTjFFpYMg/6j2Cxz40DcBshxFLdxFUaxCz+O5npl+5z18jPlDphu8kiUgUvTOo5L
         TfMyrqNtL+66Yi8vhV++3zrSWUGOQwu2/HDFFSPg9U23vgojQseLE48vYM3IApIoqFGV
         Z5TX4nYkCI9iMdZ7OW+pJuDr+OJyq5k9WHOya4rqoWRwKeefgE51fjz9531vUCHJajdz
         2YpA==
X-Gm-Message-State: AOJu0YyzRwLNSzN01jW8qCl3ziLD8+s1ysyoNKHd0O6UAH2xl2OVr7Qc
	U2rTNywdyhKRFZuJzZCs8REN2G0qII/PX2w6XCQ4imo8ZWf0vnmB3pwRlHah
X-Google-Smtp-Source: AGHT+IExkMSHrCoGJLxyTeD80zIOXj8Dcmy+YUv4Pvog1vxjoLHE4/K5+2x8gh8ve2mENen+2FXNqQ==
X-Received: by 2002:a05:6a21:a343:b0:1c4:6e77:71a3 with SMTP id adf61e73a8af0-1cae51b3c1dmr1434520637.3.1724279563767;
        Wed, 21 Aug 2024 15:32:43 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342558b6sm155181b3a.78.2024.08.21.15.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 15:32:43 -0700 (PDT)
Message-ID: <b377eda1c4cd9d6c4ad1c3d6cbed9cb1e14242f9.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: bpf_core_calc_relo_insn() should verify
 relocation type id
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, ast@kernel.org
Cc: bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
 martin.lau@linux.dev, kernel-team@fb.com, yonghong.song@linux.dev, Liu
 RuiTong <cnitlrt@gmail.com>
Date: Wed, 21 Aug 2024 15:32:38 -0700
In-Reply-To: <CAEf4Bza9Y-JO0MeomB9S+6tOr-rRp0kDe_-1_tf2ArNddfUEpA@mail.gmail.com>
References: <20240821164620.1056362-1-eddyz87@gmail.com>
	 <CAEf4BzYxrD-sEe2UE7HBFBAOxd1gW9cYLwjxjTKH8_vdxQzO_Q@mail.gmail.com>
	 <a36a3307e4102c8f05df4e1d9fd44fc7b4f77c32.camel@gmail.com>
	 <CAEf4BzZ9sYeYANVNd1RDZWc_4EqS4cpsc+DfSqnLBp9Qfh0VaA@mail.gmail.com>
	 <98527d7adc2cc4880524caecc2f6e6d022bac210.camel@gmail.com>
	 <CAEf4Bza9Y-JO0MeomB9S+6tOr-rRp0kDe_-1_tf2ArNddfUEpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-21 at 13:08 -0700, Andrii Nakryiko wrote:

[...]

> Ok, then let's do that. I don't want static analysers complaining
> about this when checking libbpf code base.

Just want to rant a bit.
Here is a footgun in the relo_core.c:

    #ifdef __KERNEL__
    ...
    #undef pr_warn
    #undef pr_info
    #undef pr_debug
    #define pr_warn(fmt, log, ...)      bpf_log((void *)log, fmt, "", ##__V=
A_ARGS__)
    #define pr_info(fmt, log, ...)      bpf_log((void *)log, fmt, "", ##__V=
A_ARGS__)
    #define pr_debug(fmt, log, ...)     bpf_log((void *)log, fmt, "", ##__V=
A_ARGS__)
                          ^^^                   ^^^^^^^^^^^       ^^
                     first format param,        prog_name         replaceme=
nt for
                     usually prog_name          cast to           first par=
am
                                                verifier log
    ...
    #else
    ...
    #endif

    int bpf_core_calc_relo_insn(const char *prog_name, ...)
    {
        ...
        pr_warn("prog '%s': relo #%d: bad type id %u\n",
                prog_name, relo_idx, local_id);
        ...
    }

And in the verifier.c:

    err =3D bpf_core_calc_relo_insn((void *)ctx->log, relo, ...);
                                  ^^^^^^^^^^^^^^^^
                                  This is a prog_name parameter

Just spent more than an hour trying to figure out why passing real
program name (char *) does not work.
I'll think on a refactoring, but that is for another series.


