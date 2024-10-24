Return-Path: <bpf+bounces-43015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D5B9ADB2B
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 06:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8082B224F9
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 04:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9F6170A0A;
	Thu, 24 Oct 2024 04:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="azCizRd9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ACD15B96E
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 04:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729745780; cv=none; b=jJkalhP6ZutIP/ax/HOkJLqAmRLbVRM+GSYz4PnhzjCWUmtZrKEb3jk9O9rIjS0LM2T1wb3LbKNAV70nRKLIsr8PPwb0hWX8siU1hax0hwuCuyPPNCnAivEzr2LQYgYTIuyxXidB93QBiY35nr3U6QMBNI8vkA9ji7AL5jOWabc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729745780; c=relaxed/simple;
	bh=UbFQ1FMeLf2d6KXKPprNkQ0pXqSBu7pAbumD3YnjCEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D93OqH1+F2zDYNToNzYEjQgYCeP3KZzhFNt5ZqqamtcbqM2a+cKQeRB29iSaaqWdxF4yomHdPR7RNmODjU7EYdA1XmgvvQX1JJ13XJ6PpQJMr7Mnite5ozFfoIlMcNZvlnDQMCrKcYS9Olpi5sPOpgypqNnOb9rk0Cy+zl83To4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=azCizRd9; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a99f629a7aaso78499066b.1
        for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 21:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729745776; x=1730350576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wAgh3V9d3ayY1SsO9aTbCGhW1qNy/fKNDncrDRcWQWw=;
        b=azCizRd99AK9QK0jJq69X5Sfm+mXDWGhAF/ChwKvyD2pmMs1OjgLkWKz26PRWjL/0y
         lK8RUR4iVyW4SZYc6x6lXxsH/omAjDcxpkjvOZU3WZq02cO+f7gWWn0TQWqDmmMpg6A7
         22MSVVBeMYVOvGHd5JNPushlpk4DyeY+lLGTbaFDSkfJw2lAxiEYQtwNLQUHwA45WzgP
         euctoRNob69cDaiKZbJXxY+cNyky3tn35RgWQG04Oo9a+SThpPinv+MqnbMmMRAV/N4h
         lRNTiGJdouN0xe7rOHbhxGyDd8Hg7mr8O0t9IUCSCu8wMPstFUD5nc9Vejjcklv13rXv
         teAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729745776; x=1730350576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAgh3V9d3ayY1SsO9aTbCGhW1qNy/fKNDncrDRcWQWw=;
        b=W+3+h8NUsMOjjC4yMHygocFdSZGhHgkffjpvs1nnMD6rgrie0Z8cianfiTf31cnUuk
         KP4d93VeeVlQDXMLfaAv4orURwyEt0NuEEIN3PU8kRqTlw98027PaaEnb04XWGYOuDC2
         pi5vvBQiPiWgMXHFTwsnWQ0HUtMf0XhuFf27X7ASnZh4wKWD2Xde6c2Ue5wswyZ30s4M
         zq0wadU81nDTVKnev2Xib58oAsRTplpU6UylxiV8X201XDKOC0JWrkV2M5VHPewJuF+B
         qqTxwCS7SlqsZWpcHTWQfIgeprcTgeQr+cUSRzAXzkg+shMxR/z50aMHFq1IkT8QHQZr
         Ff+g==
X-Gm-Message-State: AOJu0Yze303q+/Y7ki7rBV8JBUzWtlD9FpDewYMGxkone9I9/1JmYSHs
	N4TFfHNn7SjJwHaMFPdkkHQ1PcBlmZjkcXvU5bsz4vYfCjl0cCkrF0oNdn4WN90=
X-Google-Smtp-Source: AGHT+IHDnH//9idMDdF2mUwqXz3cl8aeUrWN0JN/bu4YlzVqOSs3qJQUH6qVs/V53aKlRQAVFfGIvw==
X-Received: by 2002:a17:907:3e9e:b0:a9a:c651:e7c7 with SMTP id a640c23a62f3a-a9ad19a8cd6mr71653166b.12.1729745775729;
        Wed, 23 Oct 2024 21:56:15 -0700 (PDT)
Received: from u94a (27-247-32-52.adsl.fetnet.net. [27.247.32.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a9159a27bsm559234166b.211.2024.10.23.21.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 21:56:15 -0700 (PDT)
Date: Thu, 24 Oct 2024 12:56:01 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf] bpf: fix do_misc_fixups() for
 bpf_get_branch_snapshot()
Message-ID: <sslegl4q6cax2y2zjkq66a7jwh7oxtndzbi4t4ly4fnvari4gx@oyfxv4yjtj7d>
References: <20241023161916.2896274-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023161916.2896274-1-andrii@kernel.org>

On Wed, Oct 23, 2024 at 09:19:16AM GMT, Andrii Nakryiko wrote:
> We need `goto next_insn;` at the end of patching instead of `continue;`.
> It currently works by accident by making verifier re-process patched
> instructions.
> 
> Reported-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> Fixes: 314a53623cd4 ("bpf: inline bpf_get_branch_snapshot() helper")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

