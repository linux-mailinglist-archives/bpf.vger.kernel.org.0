Return-Path: <bpf+bounces-69362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F1BB954D2
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 11:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA8CC1906D95
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 09:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8F5320CA5;
	Tue, 23 Sep 2025 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iK2s/708"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A467313536
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 09:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620621; cv=none; b=IAiNerJyR1nhIMJWJNZ8oeohnNdNf6X9k5NDq6j4Lw4ZLycoItzPtYV4yCmtHyEMLFgdhe3yNoEUpWlxXDi+sX1xgPeq8DxDPuqRLbkbQgT97EU4JnQSpVLKuK/PnpnVWG1rqwKVPfr2Zz9oH82GCdJwqgHoWU0EvlzrOZKKJ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620621; c=relaxed/simple;
	bh=dKfDpVh8msWTrDBDqVbzpowzdFUKTxgyJEtUcL8fbSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CT+MYiQt+CDmUR1dKE/seyepyrBBx3K3ssXP2rUOXwlfm8stXVWB4a25JFTsuPeTuOaJKCln5lQlZ93p9gabLv+nbW9FqkvZoWXpIwO35pj6qQpFA7HeyRpiMb7tKMEYC2bIvrPraXucy7/5B5PVe3kdfYWtQJULj0/wcdu/T94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iK2s/708; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-892db7eb552so673021539f.1
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 02:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758620618; x=1759225418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKfDpVh8msWTrDBDqVbzpowzdFUKTxgyJEtUcL8fbSE=;
        b=iK2s/708xYqenH2NntA5PUXTnxhZbTXpMfM2IPZ6mrE5SMn7CpBKDGK9VkrYFUQONo
         GX7rGpZ3M2TRkcES/9LMLADgM22kPhPpA9yb59Q0qs9HcH1GDDFCKT15tigAEWI3Ocs4
         L5GtwqvVnWC/S2ULRyp6Azn7YKGUhXhHXs5HoA8ECuph6m4rc3IdZmna5Csw8aJjHvlF
         4qIwsahEGPgiG0AGa76mjvM0gwGUnYoH9tQWL7Yjy0yCfyyg1WXAhX5IBjrgFfVBi8om
         l7wEVFAikpKz4CEmv/AggFyUpp6fz3Qhi8IUVDozNwBAq/aJagZgo0cuYgaV+cNERxwl
         nIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758620618; x=1759225418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKfDpVh8msWTrDBDqVbzpowzdFUKTxgyJEtUcL8fbSE=;
        b=H5hiHozWzpJd+xYSu2LGpBVpAbcr4gg6CgFgSxn+VoPep9ZEuNqVEmWLkycmEAulOU
         DRa9g8QoPUBkz0ozmmdvEIvrj8lYZwtXQ5sXPF3tXveBouhH/JeaIFDNKZLhUHaDwLnP
         bPvTAFoBfOMAb3BskDf5F+MJK+VFTTYZmG+Pz4O00o9hOgOMKwfSezIDJfGj3k3nMqRN
         JWrDhgk9TUi3Fs8PGOJWJWmIKh6aCvSMc5EfUsL6/Oy5oHw/9y6PeTyJrvCCVep4BpRv
         2n4PSi51HB0XuwGaj6vPHVFk+RAmmfxuNBxfMyyQo+SZMtr3TBlWWu50ngC/Rca/2E32
         eqzQ==
X-Gm-Message-State: AOJu0YyTRTvI92UnPAD46AAYXbjgpcOosZW5GaMi7LSe+sQEf2utvb1F
	3pSawT87qhBw404WYis6W8VhXCUzTQFDnTovkdjgEnKLyQecjFIKJ0ebZZ3vL5MNyTmgS+AZx1p
	mK7dLPclpklqsBdQrL4QIK3X2m4czOGeD1chwbgi2hQ==
X-Gm-Gg: ASbGncuQZ3E6VgTyZvtqiQZTDleDd8RvlPQ/TPajbtPqH5KYJgDcDY4JFv/nUV3+DTn
	66Y18mGO4cj0UCcAOiCTiV7kYkdjCO9t3SOPrstv5MHQ1JfbHw1qjhHPhSJPUmueC0VjxGchRd2
	t5dojzT1PQwXny6J3WRxG6D4FdD7pq8r0WLD2WYjsMx5beKhT5beqkW5P1n6jGyf075UZnSvL67
	InfwUvnzgABxlSG
X-Google-Smtp-Source: AGHT+IEJuvK4J1SX0MKzHTVhKvppI7P86iWwYksJPuEQJKZwjbuR1NJa0z7QabxO9bYtMS/Pl21iu0WZ/ZWCuBkD5yw=
X-Received: by 2002:a05:6e02:1746:b0:424:ed48:9acd with SMTP id
 e9e14a558f8ab-42581e8edf5mr32642295ab.27.1758620618656; Tue, 23 Sep 2025
 02:43:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922152600.2455136-1-maciej.fijalkowski@intel.com> <20250922152600.2455136-4-maciej.fijalkowski@intel.com>
In-Reply-To: <20250922152600.2455136-4-maciej.fijalkowski@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 23 Sep 2025 17:43:02 +0800
X-Gm-Features: AS18NWCoaoaMEGSK7LyZmRiOJwp7u0shXihHAa4eyMNum036Kyajq7saiaMAhaM
Message-ID: <CAL+tcoBpMOUMfgjWesPJzrXCwuLMM-Sa_GeqjrLwie8=Bi8jtA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] xsk: wrap generic metadata handling onto
 separate function
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 11:26=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> xsk_build_skb() has gone wild with its size and one of the things we can
> do about it is to pull out a branch that takes care of metadata handling
> and make it a separate function. Consider this as a good start of
> cleanup.
>
> No functional changes here.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason

