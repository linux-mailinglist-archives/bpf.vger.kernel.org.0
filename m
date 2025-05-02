Return-Path: <bpf+bounces-57186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 381DDAA69B2
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 06:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5BD03AD06E
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 04:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000891A01BF;
	Fri,  2 May 2025 04:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SwW+5u8p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E94E28F1
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 04:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746159025; cv=none; b=c5AowFGann8sHNkrmO7p6/92bNzkTm/Fil41HhMk7Ej27CDllqBGWxdJlBeuCVqgvvUju4TnyVcPJjhTk/FtBtergsIW9QVdmSaiQGvsADF9udCvixMwlqRNedReSpnmoHBhOhyVzbkozbR7tmRuxZU6W03U6TTVZ4GfOXtrt9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746159025; c=relaxed/simple;
	bh=Fge6vbi4h8wIVKsMROvoryqPHymk7npmM7v125TA0YE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=llmKyWE/x4zBlVQ8L73HfO1doK68wLAptqLFwaXMnUj/Ho6BQIwApm0PijGt1j/dhxuCqnzCZqNB9DwVbrbr2FKZAkrUQ9RCgSyPrc2DDpdQMBldWnRqAsEvM5Wvk1fjzpS9im9Du/cDkRUqv1YdO2siVtdSKnIJ9UdcL0aoE/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SwW+5u8p; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22d95f0dda4so25212545ad.2
        for <bpf@vger.kernel.org>; Thu, 01 May 2025 21:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1746159023; x=1746763823; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NfnKdBhEFEQTmr5vx0u8Q+cH2DLCEpKwxgZPzsg5YTo=;
        b=SwW+5u8pehV7HOBmr711AkfyNHOL4fSXim277UPtcieHo/u+bUdppVeYJi9OEH7zHw
         AXaNVME8WQGozDN2AsLl24+xZERh2aDwcQa0IHL7nGcXOZH5tQ7Q4ifNUWk2CcyPDxE7
         Paxpx6CDTK0irOVHkRJ61L5J4hEe+/7qOYB3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746159023; x=1746763823;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NfnKdBhEFEQTmr5vx0u8Q+cH2DLCEpKwxgZPzsg5YTo=;
        b=aqUFwvsYf0Y/vsCEf61cWumNos/tDSahsa1fqcrgK+h1164gCZ1yybrFOIx5tiI0G6
         yvTLfkbrHPFeUHIViQ79wQZzRASx+C/Ay69x7uni2ATYxJK0PEA6bxeQKwLJstcxCulP
         DXCKq6qHEvSFqHU/BfnH/zB0OcAS2kLHxHNKDZpK1d0+N0z9v+OCbwc2YQ+opSfzCOmH
         bzBZdzf9uuqic3XZYmdFUkN8UJ3wZuSejDtBzr8MdxB53pbQ0m9WHD83fxt2Ixgcnq2t
         iujdgL5jXAZfVyYdyk4QQMZmB2/M+Nb7VVdd5vqR7SjA+LtnoaHU1gMHvgufTbeyLUZm
         f1lQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdzJibia5/22Z6llxrGjjAX/yLk9chDNdBOrDomsJw2rrYZXZAAVCEshqMSWhAjgjmLGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwvYilVBEjz+DsL/mCCW0H3XCxr3Zg2IqOlVvHdbx19qRS2nJ4
	IrAN7WFNqyv+R6EYzCN0nnxcihjO2xM9aU7j6U6gVCyh8bOf3L4Srha17+RyQtLjhX+FXmZR2QE
	vBg==
X-Gm-Gg: ASbGncugvnUe0Cfn5YUxKsDMcLzrXY8eByviOaH4x70ws4UWk7OYYVLo7Qcgf1Jlg5p
	6bP8rMM35tlZOIz380uvRXHXidoC1t7fTK77KQT1cCTZjmu1XeeMzpPgWXBuUv0P/sC5D7yAq8G
	f/jyResdOf1FFS0I3E+6VxIiitrGWU28ndsGc3GO+2FaLMrlvxqUE3aIZSYGRf/2yJJFsozpw2/
	dNDfow5n76oHmhsw50jjykAJ7Pjq8S4Dg3gtJGGXsEWUbxHQZ8aJA5EoYACPrnECeTpc3Dk3gdy
	mz2VrCzHe/V1JcbDt8x6vVZbl3xycDj+Mv5MPzU3eK/B
X-Google-Smtp-Source: AGHT+IGk019uAAzwpcoNOri8EvY+EgL6M/1hb3zuMucldw9qtnEJAh2U3yfPdTqVBRb9VWQqXWbuJw==
X-Received: by 2002:a17:903:187:b0:223:517a:d2a3 with SMTP id d9443c01a7336-22e1032f5a2mr22798395ad.17.1746159023382;
        Thu, 01 May 2025 21:10:23 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:5d10:8616:2d1f:ee5c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1085e0c6sm4644385ad.75.2025.05.01.21.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 21:10:22 -0700 (PDT)
Date: Fri, 2 May 2025 13:10:18 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC] BPF fault/jitter-injection framework
Message-ID: <5l4btekupkqatpxkfaolqhc5kw5wra3xvd7dosalem6zuo5vp5@vwfd7idoqdzv>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings,

I've been thinking what if we had a BPF jitter/fault injection framework
for more fine-grained and configurable kernel testing.  Current fault
injection doesn't support function arguments analysis, with BPF we
can have something like

    // of course bpf_schedule_timeout() doesn't exist yet
    call bpf_schedule_timeout(120) in blk_execute_rq(rq) if
    rq->q->disk->major == 8 && rq->q->disk->first_minor == 0

So that would introduce blk request execution timeouts/jitters for a
particular gendisk only.  And so on.

Has this been discussed before?  Does this approach even make sense
or is there a better (another) way to do this?

