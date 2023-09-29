Return-Path: <bpf+bounces-11108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F8F7B34E6
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 16:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 44714282583
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 14:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5E751220;
	Fri, 29 Sep 2023 14:29:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D571F4F124
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 14:29:14 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22648F9
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 07:29:13 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-690bc3f82a7so12104604b3a.0
        for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 07:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695997752; x=1696602552; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nvalNltjLz9adeyezSdNpn/HXtzEYyQkHd66K+vSLkw=;
        b=VcRUuvbHh6Je7/cje6xT4tucf+ucviEF698VrrfRskX7krhalik06bJOT/4wN5fmj9
         rnOS05zm4xTxmuxTSVGp947ntyDdqIjjIe9DsRUsVU/O5rp1lCvWBHMzqiXx2UhdhvIO
         ZVXnNEuLOEJFiitqe6tFqU1TGtTP4oQ1y2VhcVd5iBDRxJf9K/cP42RWzf39W7Bgg1Nr
         /r4tLWHxpfPGH58WtVxSJOO7/fyt57nUzNHgocVIVOkmUcLPgaWruT2QOp5dh91JjiJ2
         AHBFKjyfL/EKwkct7ibyFZqtQepwYdZUygKxRwO5RaALAa/4lplORHtAhSOJqXwn9zSt
         TUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695997752; x=1696602552;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nvalNltjLz9adeyezSdNpn/HXtzEYyQkHd66K+vSLkw=;
        b=PMrMYY8qc9LJeqYnVzLD5fHSVxKJjMPS96rUz9OsJHj/0pkDOl4i2J7T/8rhfSl/jl
         fWy2qNMd3nZLOX32J7LxmZ67Qb35003mLfq1OHCd3T2sCYgnz6AKaRwyap8Vegnah9Qi
         pRmKlZT8L44OKT38Wl8tlmwEtAGCd8EWBCydYhrk6EnGr7sPERl5xIFZgFzwmO5I5UPy
         mGdNkRzQKGe86T/N9EZbLi0SCniZFMWdtnvJK//OoH+IwSvMaeq1xdwv/L45JTtvW2yU
         w8SCRZoauIZlIzh3//OvVqF95TVG8+xbT47Kvg2itJl1hxClLvW8BeIg9GTI7731VmjD
         A6XQ==
X-Gm-Message-State: AOJu0YyY6Dfo4csSNVBHgyubN6kmsiuh8gx4e7/slBLV0IL9Bj2iTaHz
	6O7M/nNYlmYJhbfjigP3uSamP1N1ij2fyoz62WEIGkANxldBqg==
X-Google-Smtp-Source: AGHT+IEP1cqow5L1B9jqg4bj57a7SPzdNh0rz4AFtBVdAOGkLwmnUVZkoJ0JhXuqkh/Cz1r6JczroUTGAulES8FLyTE=
X-Received: by 2002:a05:6a20:9143:b0:15e:b8a1:57b9 with SMTP id
 x3-20020a056a20914300b0015eb8a157b9mr4816514pzc.24.1695997752257; Fri, 29 Sep
 2023 07:29:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Suresh Krishnan <suresh.krishnan@gmail.com>
Date: Fri, 29 Sep 2023 07:28:59 -0700
Message-ID: <CA+MHpBoHdG4ptYsdeHaEUNqmyPYYgavWUpMbVW5zzOzUoLUJMw@mail.gmail.com>
Subject: Call for WG adoption: draft-thaler-bpf-isa-02
To: bpf@ietf.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi all,
  This draft has been presented at the bpf meetings and has received
significant feedback both at the meetings and on/off list. Dave has
published a new revision that addresses all the comments, and has
requested WG adoption of the draft. This call is being initiated to
determine whether there is WG consensus towards adoption of
draft-thaler-bpf-isa-02 as a bpf WG draft. This draft is expected to
address the WG deliverable

"[PS] the BPF instruction set architecture (ISA) that defines the
instructions and low-level virtual machine for BPF programs"

The draft is available at

(HTML) https://datatracker.ietf.org/doc/html/draft-thaler-bpf-isa-02
(Plaintext) https://www.ietf.org/archive/id/draft-thaler-bpf-isa-02.txt

Please state whether or not you're in favor of the adoption by
replying to this email. If you are not in favor, please also state
your objections in your response. This adoption call will conclude on
Friday October 13 2023 (AoE) .

Regards
Suresh & David

