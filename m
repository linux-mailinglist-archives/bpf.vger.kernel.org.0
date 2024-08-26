Return-Path: <bpf+bounces-38047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2E495E92A
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 08:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B59F2810EF
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 06:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A6813CA9C;
	Mon, 26 Aug 2024 06:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H41aE+yW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6839513C9A9
	for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 06:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724654287; cv=none; b=eqjiHTIIFL71YiRHyLr5+eQY3GpBijZNlB9W785Jmrj88t9BXHTvzkleUzqWUZCUE7FKQT+eP1Fa1DZfACIW62nGeiUwZjW6rAG9Fk7UBRDckTmX1mYh4lGg7sEz6WeRdPavWKSAhLPM6uPcIXBbUNpvf+ptEiAqf+YQgDekuCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724654287; c=relaxed/simple;
	bh=ZjO9jBhOh/+PkmfehpaZieVN4n3HItjdXv9cpOwEUiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ViaIO51dqT42OwTG66k2BhMRssO5s0wPSgZefNY7V3OScVNDYlAhkpVKa6YdopeyKfNyV2VP2PwvzqJ2UvlDRCnF3149lpznGVsuOHXlaWQL9kDEz37wIYq8re0oqPUYrkPUni3JqHBLzehUXi9PvLquIpfYQFjybiwedp4OZ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H41aE+yW; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3718c176ed7so2181041f8f.2
        for <bpf@vger.kernel.org>; Sun, 25 Aug 2024 23:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724654283; x=1725259083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AtT/7Je7rLssvh0LkLQQndPhNwjWpBf99LGxasDSs2A=;
        b=H41aE+yWvcaEIDVdHboNEXSdz8fBocjuE9VcdWr9j8YNstiXyPvRPw8j/T8CZfi9yI
         XWe78npRff67ifilVU4NJPfuqyYgkgmuVGSWuwFo9SvnA7/dfnOjFttVUCJxgXJRB6lQ
         GGBeAckUkPhDXN+lCfpkcE4EWNF9lZCma7rAXpeEMG5voduiJPq4ZcZYr/TSzynwoTYM
         cF6hYKCm61XBAzFbNIDleVRgauS08/M9Or1UKcs3vnlYCxTHVYRcP4s2rMp8cY7Q/opb
         5FTkjUM+RZKD6B2hktuvGeCb0tyieN8qsPXBaHEIyk2zUQJjWkafwI3+PcM+gSIGKbVQ
         IHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724654283; x=1725259083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtT/7Je7rLssvh0LkLQQndPhNwjWpBf99LGxasDSs2A=;
        b=eMuzsSd+4VKJSWMIuM50qlh2LAgWuAp1HtMlYEToxfaCw88Kd/ELz80pDO0v62p0PM
         u417Dn3HgY1A/YbCWXd1oVTOMnjb+ydo4kkxeIlvDxLQN/oLiqShjMLH1swMZgaaN1tT
         IqhR0cU3Vlg4aVfFN/4VIH9Gq2zPKLCOGfnXkIpaGGFNkRCqVZyOXk5oE194rggPHzGz
         6EBJ7JprqtVrjQl0aGpxuN4qpxPw+rOpc3GRz/rnzyFDkjUjlCd1W9E2R6Sa4C57zEhj
         B9KGn3U6IYTdt6awoO7kcVkkMsDTaNjQquLoZcHYVIU3WUkvV+0Aq88DQSuQ+HIymsq/
         n9iA==
X-Gm-Message-State: AOJu0YxV3hqGTYJeeXxwp2lXYY+gdQkmMfsUQEvOR9Jf4APS5bWaKDrW
	6yKemFeYTq1b6jpPB6gMbu7uwg4FyMSWBeyCTZAbmQlD0yJrG9AoLG853bS1dcs=
X-Google-Smtp-Source: AGHT+IHNHJAOyRGUg2q//uopcaKuYxWHay+JBRc3S2jTDRPWeI7ttnb9+P5giIuSpolGhU4vJljZAg==
X-Received: by 2002:a5d:68cd:0:b0:367:9d2c:95ea with SMTP id ffacd0b85a97d-373118e353bmr5348472f8f.56.1724654282526;
        Sun, 25 Aug 2024 23:38:02 -0700 (PDT)
Received: from u94a ([2401:e180:8812:1b5d:e57e:cdf9:3562:dd80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20395ef904dsm49049205ad.31.2024.08.25.23.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 23:38:02 -0700 (PDT)
Date: Mon, 26 Aug 2024 14:37:40 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, kongln9170@gmail.com
Subject: Re: [PATCH bpf 1/4] bpf: Fix helper writes to read-only maps
Message-ID: <dzcec2sraaz7tvxxcq4kl3ab3akcfqebzuigznpihzlfrby65v@y7hetupo2saq>
References: <20240823222033.31006-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823222033.31006-1-daniel@iogearbox.net>

On Sat, Aug 24, 2024 at 12:20:30AM GMT, Daniel Borkmann wrote:
> Lonial found an issue that despite user- and BPF-side frozen BPF map
> (like in case of .rodata), it was still possible to write into it from
> a BPF program side through specific helpers having ARG_PTR_TO_{LONG,INT}
> as arguments.
> 
> In check_func_arg() when the argument is as mentioned, the meta->raw_mode
> is never set. Later, check_helper_mem_access(), under the case of
> PTR_TO_MAP_VALUE as register base type, it assumes BPF_READ for the
> subsequent call to check_map_access_type() and given the BPF map is
> read-only it succeeds.
> 
> The helpers really need to be annotated as ARG_PTR_TO_{LONG,INT} | MEM_UNINIT
> when results are written into them as opposed to read out of them. The
> latter indicates that it's okay to pass a pointer to uninitialized memory
> as the memory is written to anyway.
> 
> Fixes: 57c3bb725a3d ("bpf: Introduce ARG_PTR_TO_{INT,LONG} arg types")
> Reported-by: Lonial Con <kongln9170@gmail.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
[...]

check_raw_mode_ok() might need an update as well since it currently does
not take ARG_PTR_TO_{LONG,INT} | MEM_UNINIT into account.

Aside from that LGTM (for this patch).

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>


As a future refactoring it seems like we'd be better off turning
ARG_PTR_TO_{LONG,INT} into the more generalized
ARG_PTR_TO_FIXED_SIZE_MEM?

