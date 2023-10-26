Return-Path: <bpf+bounces-13342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E36D7D8758
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 19:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A7EF1C20F73
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 17:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3F538F94;
	Thu, 26 Oct 2023 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEmwCysu"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD62D381DF;
	Thu, 26 Oct 2023 17:11:27 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76225D40;
	Thu, 26 Oct 2023 10:11:26 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6b5af4662b7so1090487b3a.3;
        Thu, 26 Oct 2023 10:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698340286; x=1698945086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ykb4Q1y7dfN3TFCtRf01R1L6KzPjKOLsxYjo41J/L4A=;
        b=bEmwCysuO6pdXdICdwB1bczTBQaf1huY0lJanhKSemAYhUIeKUtrc5dKgMBOhrYI3v
         d/7lU3kPo9zR7ypAAwfYfpaJKsDfvK1rFhqdQzFxTtbx0fzLL1Zgm505x8NFzqZ0Ha7x
         wMc2PnyR+pi81n/YhVQZpEMa1LJMkfEN+dDD+OthjkRkoalFeKCG8mFB8xFjlNqKzyrJ
         DKeaMUxb10NNjTc0tf3bellC6rIIMaPMMpnbC5vdtgPNAxcLPFOCV08GX+zvo3vVA2f9
         emBg6gdBL9kDmXXxvirsn1OfpMrFzQpzD0C4eohJ21ybsKz8IridvTkLEywfDCK9Eb2T
         G2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698340286; x=1698945086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ykb4Q1y7dfN3TFCtRf01R1L6KzPjKOLsxYjo41J/L4A=;
        b=Uk96gFwOsN9HXMIhsSZq1lFgEOuIdHByQaxNZ/IDsZy/ofQw+OjPiNi1N2kpEbWMqY
         MyLYVUqhKD/sOeN1ViQIDsgNLvOdDiRIu3IJ0jtOlWmVaEhPLiHeJLRU4Zufa6Mxrd+3
         pyWGGaka1STtq7n+xYe1VwuX48/pPx72tXDFvNwABTdpl6L1TySPk7vWOZrMqpBAvjjI
         a09mjbxn3HSWWUn7+AyqxLIktRMDbKlJYxtrNVJcY//hCHzbw4Qh5BRBV/2Jt4HVLshw
         8xqoWkf3LEikTAzc5UhZveWR81wzQCQe6iX9Lo2Q+oXO6YFDtvZgyDe9e1yWYdLB2fKS
         sGMg==
X-Gm-Message-State: AOJu0YwmkfV6WbXiI7UecpGBrMP25SZL4N6NoHNkpTCh4nF6lUSlm/xu
	mXz3fqFeR8mydhNyeFDlCo4=
X-Google-Smtp-Source: AGHT+IGyET22K6+7YGTrkRiBzmcp8nBei0qE3r/2ecYYK88DNgibhj1n3IgLZAlWRCaQsSj7PIyH/A==
X-Received: by 2002:a05:6a00:814:b0:6b2:2a2d:7a26 with SMTP id m20-20020a056a00081400b006b22a2d7a26mr108343pfk.28.1698340284398;
        Thu, 26 Oct 2023 10:11:24 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:ec51:cb82:a169:2ada])
        by smtp.gmail.com with ESMTPSA id k15-20020aa7998f000000b00688965c5227sm11356315pfh.120.2023.10.26.10.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 10:11:24 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Song Liu <song@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 1/3] perf lock contention: Clear lock addr after use
Date: Thu, 26 Oct 2023 10:11:12 -0700
Message-ID: <169833996388.1181734.6181786783343850640.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231020204741.1869520-1-namhyung@kernel.org>
References: <20231020204741.1869520-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 20 Oct 2023 13:47:39 -0700, Namhyung Kim wrote:
> It checks the current lock to calculated the delta of contention time.
> The address is saved in the tstamp map which is allocated at begining of
> contention and released at end of contention.
> 
> But it's possible for bpf_map_delete_elem() to fail.  In that case, the
> element in the tstamp map kept for the current lock and it makes the
> next contention for the same lock tracked incorrectly.  Specificially
> the next contention begin will see the existing element for the task and
> it'd just return.  Then the next contention end will see the element and
> calculate the time using the timestamp for the previous begin.
> 
> [...]

Applied to perf-tools-next, thanks!

