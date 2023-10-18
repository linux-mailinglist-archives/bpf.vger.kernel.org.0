Return-Path: <bpf+bounces-12582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4282E7CE29B
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 18:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA764B21124
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 16:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29893C088;
	Wed, 18 Oct 2023 16:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qAkKjpQY"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111D51F188
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 16:22:27 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55A7BD
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 09:22:25 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-419b53acc11so296661cf.0
        for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 09:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697646145; x=1698250945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ESBoSu0Q2kOoNHH1TTBfnX4/YG198ciywvQbN8v9rE=;
        b=qAkKjpQYe9q7oGFfKOnW7ZwiMksJrbGIpxRFd6Anm6Vb23Y6QBXxgGhdlkhfRNZRMO
         qDgJ3XYNbPJqav4D/Q+XDYO5hSCzU5SNv4MYpLtyHEjdsCQhMFVguzQ66ikmIiK/d12O
         vvyJXFqqJXxfElT7vW5s8b1gcORAaTmZe8caGIYq/oI4d84ds5w8Wfj1/WqC8iRaECUj
         qZPgUv8MBkS83XmS+oChcmjyTdF0pNkR20hOYqxUu6giqPePxyvyIP3Ic/vqngEjOEuS
         pGcVDaxEIGmqLmwQPc+z7eMLtGEXheIoSDz7/fCTvb1H/eUYh+BeedpyniaHVNJd1tQU
         sajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697646145; x=1698250945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ESBoSu0Q2kOoNHH1TTBfnX4/YG198ciywvQbN8v9rE=;
        b=Yb3+8oW9kiRvrbXa8GhrC2N7kOdL6ZQpXL4GZ0nc77ikDPhKSs6ikCmq90gMgeJbPN
         I41siIsnimuO+US7PlGkLnr8o1JvJGWiq2Z2j1Pmw848dc5/fwoJeNGJz709uFe0zWTx
         WbwPB5voU/fQW0ibSA+Sd6y0Y38Nz7k0A1fxm+LPHQxgxNTmCg0S6pW9TRVUYPoPZBvz
         1OgaUpq6/NOl3VZqU6qRn/6LBiaJfq8JdZC5X95hy7Yn8wDthqciQbrsCk7mFrI0DFHj
         xrgosiJOCt0XtrFLtL3UviKrGOE4UaXaXHajadlauffqmXdO6Dy4qqWm0xevN37DdNq4
         JaoQ==
X-Gm-Message-State: AOJu0YyATIuFCteuFxBhK1snqnnzcrMVWok7RH/JgT823Y9k+6Pkco3w
	mYZFaUDUO0TDh3EDeVvl9G7sI06yL7Hn+C7jUH/dzg==
X-Google-Smtp-Source: AGHT+IF6mJk4QPRLAjJWI/o6MMUeKJaaas0JnbYE4DP1GoPpKt3v9snrBQH4kk0quh0gH9SuLieuXsPbaCYJn2+Gj98=
X-Received: by 2002:a05:622a:7711:b0:41c:375b:81a3 with SMTP id
 ki17-20020a05622a771100b0041c375b81a3mr321200qtb.18.1697646144607; Wed, 18
 Oct 2023 09:22:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018082104.3918770-1-link@vivo.com> <20231018082104.3918770-3-link@vivo.com>
In-Reply-To: <20231018082104.3918770-3-link@vivo.com>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 18 Oct 2023 10:21:47 -0600
Message-ID: <CAOUHufbPiAhpvHuo=oH7Zhyoc0hR-6kpVrCEe-b0OuWYWne2=A@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: multi-gen lru: fix stat count
To: Huan Yang <link@vivo.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 2:22=E2=80=AFAM Huan Yang <link@vivo.com> wrote:
>
> For multi-gen lru reclaim in evict_folios, like shrink_inactive_list,
> gather folios which isolate to reclaim, and invoke shirnk_folio_list.
>
> But, when complete shrink, it not gather shrink reclaim stat into sc,
> we can't get info like nr_dirty\congested in reclaim, and then
> control writeback, dirty number and mark as LRUVEC_CONGESTED, or
> just bpf trace shrink and get correct sc stat.
>
> This patch fix this by simple copy code from shrink_inactive_list when
> end of shrink list.

MGLRU doesn't try to write back dirt file pages in the reclaim path --
it filters them out in sort_folio() and leaves them to the page
writeback. (The page writeback is a dedicated component for this
purpose). So there is nothing to fix.

