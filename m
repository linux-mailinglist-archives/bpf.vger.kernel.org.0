Return-Path: <bpf+bounces-39205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB54970962
	for <lists+bpf@lfdr.de>; Sun,  8 Sep 2024 21:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 044DFB2125A
	for <lists+bpf@lfdr.de>; Sun,  8 Sep 2024 19:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEC21531F9;
	Sun,  8 Sep 2024 19:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnpikwOU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575F4178364
	for <bpf@vger.kernel.org>; Sun,  8 Sep 2024 19:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725823156; cv=none; b=Dj+4sA+MDkEkDBXocAABwD5TxSudEcZ1aE4qwjhwhmcmjjPhqW7ta6MAjHCOrpMSPofAWkw15YRstUZQyZPHLAzEk2em/ZdF+pPUAhyP/sKoj/oTKlM4pVZUxqxZdgMQgSIBQCwQYgV9XLglPQVCVcPjzjzVD/ar5PH/LLBrUV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725823156; c=relaxed/simple;
	bh=0WYYOzS8jMWl/ka8o6magKugT6OF5Ittik41kzAYtOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmPG+QlbFEYdAx36Oa9WEGJiSEH8+jVNa2MLJ2Rqp4InEWXD4WwrjxnRtfIufqQDxoqCPxHT7fLR3uFgpTF2YUbRJT2NMQUndc17eAWB1+I3k09xd2DJfXU+IsQgVTizjoySXBeKe6q92pdAYdhqUa2N/Penr9zSz5ToaF0liFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnpikwOU; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6e7b121be30so2351342a12.1
        for <bpf@vger.kernel.org>; Sun, 08 Sep 2024 12:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725823154; x=1726427954; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Egzeqfy7fD83mG5DtqxFRURS74OykOxBDgmT9EJn+EM=;
        b=FnpikwOUYlVuvRiFHRgrFLSRLyWEITbtLQidir4OcUWAx/q8YuXK1zBvoeDUSh8SVN
         JN/+qmY8vC3r565hPDnbMv6MsONy7b/oy8lE6DEc1ezDQMM7+Evf+LDnzo9NNjeOnvA8
         N0O7su2eWxSgTkDTCr+n0IaDe/uHfGG7ezbtRJStTU6AtN0sOufTp9pWQ3jkY+FDulbS
         0Y4t7hrLLh3I+mJ69itcyka9yGkF/bWtRDW22Vr/V0nJJ+YL5QrJVSA4U6yvpvUxLZgP
         734aaQiew8l6CqA92Nhj5FlOBJTrJtDOl+sy/4/DTlz7k4C2ZuZiLuJpMXhxo3U/DkBZ
         Q77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725823154; x=1726427954;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Egzeqfy7fD83mG5DtqxFRURS74OykOxBDgmT9EJn+EM=;
        b=GEy60tRlMBCOmi2zwfkrJVvJc+VXo14hxcuvs+ezGtKSk2dUNNp54iLOrZnDIQHpLn
         Wb2hYLaE71ZzxMj4S1Gr8fLR9GKhEvIp5nppZFpPt84CSLZpKOHmTKfGom2SJ4E4wSb0
         S6HF+TqovUpJCy7lDQIyzoqsFcZ7MKPzQa70Sq21cENpDtne3sW6hmMtmGhfuNcVNIw8
         4DVjsPGCGwIGZA83VHWDpG7oS8VuxEvO8nfvPbMLjCLKWlJyOhsAaD1j/eX5Omf6+/a5
         LCsTFyz3wx9KWLQzRQub5Pvmtyo1aeSpVwH4AcfK8wNVyNrCjTucUxxMsuV2A6g2yJNV
         E22w==
X-Forwarded-Encrypted: i=1; AJvYcCU21GKlbYbAlhkR4Nb9kDGgVWqWBXzNZ0iTuN1SzcMj2hFIVwQfXpSoGTOmacKoA63ofJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC750n5+GRWIxRuwdDo95GhbzWvlalzF9PXwGd4/l8KnE9zCpG
	D4AuDkkkv3bsHOLUCj9r9aW0cnMB72C8O0DgMt1ZxVjVH0ezsc1E
X-Google-Smtp-Source: AGHT+IEnNb8VHXpMDDgreiCL+ZRH5sy8dOFRcBVvaQgLLc+h3PrEt5bU+d6NtNW1RRUuWX82xMbzjg==
X-Received: by 2002:a17:90a:fd13:b0:2d8:9a0c:36c0 with SMTP id 98e67ed59e1d1-2dad4efdcb9mr7302080a91.8.1725823154432;
        Sun, 08 Sep 2024 12:19:14 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:4334:4d08:284:9405])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db04988c97sm2993731a91.55.2024.09.08.12.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 12:19:13 -0700 (PDT)
Date: Sun, 8 Sep 2024 12:19:12 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Priya Bala Govindasamy <pgovind2@uci.edu>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Hsin-Wei Hung <hsinweih@uci.edu>,
	Ardalan Amiri Sani <ardalan@uci.edu>
Subject: Re: Possible deadlock in pcpu_freelist_pop
Message-ID: <Zt34sPvu9mO4Tcgv@pop-os.localdomain>
References: <CAPPBnEa1_pZ6W24+WwtcNFvTUHTHO7KUmzEbOcMqxp+m2o15qQ@mail.gmail.com>
 <CAADnVQLAHwsa+2C6j9+UC6ScrDaN9Fjqv1WjB1pP9AzJLhKuLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLAHwsa+2C6j9+UC6ScrDaN9Fjqv1WjB1pP9AzJLhKuLQ@mail.gmail.com>

On Thu, Sep 05, 2024 at 11:40:06AM -0700, Alexei Starovoitov wrote:
> On Thu, Sep 5, 2024 at 11:37 AM Priya Bala Govindasamy <pgovind2@uci.edu> wrote:
> >
> > SEC("kprobe/__pcpu_freelist_pop+0x58c")
> 
> We should disallow such recursion in the verifier.
> All these "bugs" are hard to prioritize as bugs.
> When people shot themselves in the foot there will be pain.

diff --git a/kernel/bpf/percpu_freelist.c b/kernel/bpf/percpu_freelist.c
index 034cf87b54e9..14c9fcf81ac6 100644
--- a/kernel/bpf/percpu_freelist.c
+++ b/kernel/bpf/percpu_freelist.c
@@ -187,6 +187,7 @@ struct pcpu_freelist_node *__pcpu_freelist_pop(struct pcpu_freelist *s)
                return ___pcpu_freelist_pop_nmi(s);
        return ___pcpu_freelist_pop(s);
 }
+NOKPROBE_SYMBOL(__pcpu_freelist_pop);

 struct pcpu_freelist_node *pcpu_freelist_pop(struct pcpu_freelist *s)
 {


