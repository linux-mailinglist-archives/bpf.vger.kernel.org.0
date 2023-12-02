Return-Path: <bpf+bounces-16521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7B3801E5C
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 20:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0EB01F210B2
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 19:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B102B2110F;
	Sat,  2 Dec 2023 19:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="oVgw5K/n";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="WTB8taal";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="AU+gvwOy"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E94AB
	for <bpf@vger.kernel.org>; Sat,  2 Dec 2023 11:51:58 -0800 (PST)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 8A4EDC2395F0
	for <bpf@vger.kernel.org>; Sat,  2 Dec 2023 11:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1701546718; bh=wx3xXKFh07905Xy960SeJlnsZOyRgvlS4JPhE6ViCR4=;
	h=To:References:In-Reply-To:Date:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=oVgw5K/nuWApXuRM8VoFaBm7aWo/48fBb+bcMSqhsFwEqVSFm/lu7geUim3QEoQKC
	 +yoVyqhcxzXV05IURxkX0slnh1UJP2xchID5GyWYR78wZp0cLsUtqDa+tLmySkg69t
	 Q3v3IdlvN5UptN05cdJzms5H+XEadYP8mDG4WSn0=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 5AC1DC14F5E8;
 Sat,  2 Dec 2023 11:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1701546718; bh=wx3xXKFh07905Xy960SeJlnsZOyRgvlS4JPhE6ViCR4=;
 h=From:To:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=WTB8taalazSmciHLhmOdQIcm2Hlk7d1wDo11AeuskqYvv1Q5X2sXASoSzlxvOOeol
 0y78MCkOZho46vBkJGhmANZYV/cmjGUwRztptsCQtIJ2lp1biDqGo3QfwAEZORHze0
 kFFoMVGk4YIQjoqUo8pgDNQv9+NI90wY4WtIKBbk=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 9B8DAC14F5E8
 for <bpf@ietfa.amsl.com>; Sat,  2 Dec 2023 11:51:57 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -6.856
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TFDtiuHLLSTU for <bpf@ietfa.amsl.com>;
 Sat,  2 Dec 2023 11:51:53 -0800 (PST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id C58FAC14F5E6
 for <bpf@ietf.org>; Sat,  2 Dec 2023 11:51:53 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5d7692542beso4615167b3.3
 for <bpf@ietf.org>; Sat, 02 Dec 2023 11:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1701546713; x=1702151513; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:to:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aVX0qvTOmorhdO0DNiBrTIQzItZCLgg4Yy6zAZ0ixYo=;
 b=AU+gvwOyAYMDUPFeZF6KkHzB6TzniY7UDSKHkrsTv4Z6LqrlJim1Vtl3NC1gU/A23W
 xTrEmAc5QOPpEE0JPaFsnK2Ntb6vsBFCrhQooe3Quln/9ZPfUNUOCnhUXn77GDdekaTB
 +vwKMPs9dOvUCCvixEcPHOU0J8ClPaVBue0lUlHysmv01QK3K/JMqBaHOyX+eQXyfTYo
 Tq58Jlg9KYPohdj2qZebiau9JrochNaA4Ef7vcfgifbPeq70tgrERjAGb+fd2FpqS5ue
 M2hMlDZ7mmnYg5ZB0Ys04r8R30L9Sl1FtQEJlPsj1UR/07TsdCXu1FMcdJ81a0eu3lw/
 pN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701546713; x=1702151513;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aVX0qvTOmorhdO0DNiBrTIQzItZCLgg4Yy6zAZ0ixYo=;
 b=hRKwzZdzP1VQf2XdPlf2LAXTCW31F/0XnLj7oXlnTqnQ7yoK+UFH1L7csTq4CbVCXa
 HBSdSqLPua5pQOTGEJpOtmLg/p8+xjRlEj6W72wdKkide3hN7QoWRalgsLdZPWO/+LQU
 Qb+OeZDkElF5rVskuSXVdvcIay4K1kDuF7f5+g6l3BCnNeFThY3YceHey4xQHESYuEr2
 XIBKQQb9+L2/F+7WbBoEgcF379gLDGpqHuc+ISpkVPon68KNA+dAlloDoVD4qEFZ/T48
 tPfjleuYTeeqw+C2cUCY/qgvkmcJUbSsEaimojBSzbpWrXd7EuKXrbVSFoo/bbczVjKt
 +BcA==
X-Gm-Message-State: AOJu0YyGWkcv4VDV6lG1ycPwe73HH9WRgEYUS7AbYAkKipyZY1QFIWfx
 XtNxdTyb+5EgAW0f5ga80V2RTvulbJJHMw==
X-Google-Smtp-Source: AGHT+IG4/2gJaqctvwdym2R1wwATk2b95a9iMCUDgEUJsYYRU3riRtJxCKeKk7vYK/Xw6/nUgO1NQA==
X-Received: by 2002:a0d:cccc:0:b0:5d3:c436:b05e with SMTP id
 o195-20020a0dcccc000000b005d3c436b05emr1307770ywd.25.1701546712682; 
 Sat, 02 Dec 2023 11:51:52 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 d125-20020a0df483000000b005d7993a2675sm312658ywf.31.2023.12.02.11.51.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 02 Dec 2023 11:51:52 -0800 (PST)
X-Google-Original-From: <dthaler1968@gmail.com>
To: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
References: <20231127201817.GB5421@maniforge>
In-Reply-To: <20231127201817.GB5421@maniforge>
Date: Sat, 2 Dec 2023 11:51:50 -0800
Message-ID: <072101da2558$fe5f5020$fb1df060$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdolVnQZkE/iSEhRQEGd1bBxuSER0Q==
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/W_GWZeh3cUPN0o1D0Lxwwbldfi0>
Subject: [Bpf] BPF ISA conformance groups
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: dthaler1968@googlemail.com
From: dthaler1968=40googlemail.com@dmarc.ietf.org

>From David Vernet's WG summary:
> After this update, the discussion moved to a topic for the BPF ISA
document that has yet to be resolved:
> ISA RFC compliance. Dave pointed out that we still need to specify which
instructions in the ISA are
> MUST, SHOULD, etc, to ensure interoperability.  Several different options
were presented, including
>  having individual-instruction granularity, following the clang CPU
versioning convention, and grouping
> instructions by logical functionality.
>
> We did not obtain consensus at the conference on which was the best way
forward. Some of the points raised include the following:
>
> - Following the clang CPU versioning labels is somewhat arbitrary. It
>   may not be appropriate to standardize around grouping that is a result
>   of largely organic historical artifacts.
> - If we decide to do logical grouping, there is a danger of
>   bikeshedding. Looking at anecdotes from industry, some vendors such as
>   Netronome elected to not support particular instructions for
>   performance reasons.

My sense of the feedback in general was to group instructions by logical
functionality, and only create separate
conformance groups where there is some legitimate technical reason that a
runtime might not want to support
a given set of instructions.  Based on discussion during the meeting, here's
a strawman set of conformance
groups to kick off discussion.  I've tried to use short (like 6 characters
or fewer) names for ease of display in
document tables, and potentially in command line options to tools that might
want to use them.

A given runtime platform would be compliant to some set of the following
conformance groups:

1. "basic": all instructions not covered by another group below.
2. "atomic": all Atomic operations.  I think Christoph argued for this one
in the meeting.
3. "divide": all division and modulo operations.  Alexei said in the meeting
that he'd heard demand for this one.
4. "legacy": all legacy packet access instructions (deprecated).
5. "map": 64-bit immediate instructions that deal with map fds or map
indices.
6. "code": 64-bit immediate instruction that has a "code pointer" type.
7. "func": program-local functions.

Things that I *think* don't need a separate conformance group (can just be
in "basic") include:
a. Call helper function by address or BTF ID.  A runtime that doesn't
support these simply won't expose any
    such helper functions to BPF programs.
b. Platform variable instructions (dst = var_addr(imm)).  A runtime that
doesn't support this simply won't
    expose any platform variables to BPF programs.

Comments? (Let the bikeshedding begin...)

Dave

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

