Return-Path: <bpf+bounces-31270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AE78FA5DD
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 00:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D681F23F42
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 22:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8939413D26E;
	Mon,  3 Jun 2024 22:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GlLbdUhx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D5013D245
	for <bpf@vger.kernel.org>; Mon,  3 Jun 2024 22:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454322; cv=none; b=LG78wPOPUoYl+ZkkL2fK1a51FVWA65x8kdDTW3hAZXqXMePDtP2wP1KbA8NZhVYrh3IuGtTLTsf3Es2Qxxtge6e2fbXwYT5zET64kORY4+cJ4Qc9icrDquCTwn3tovgPSYZvP3NSzIPMVfX75kKxVxXf72nnawXZZx/jUhM5D30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454322; c=relaxed/simple;
	bh=ADQ686y0LUmppB8hKb1UqpO0JQXUA06qEhc0vs+CvAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+VcWWK/b8/mT7wr+uRegBeOyL9aqlsSkPJxcwL8KjLEZE/PnPGig46JPnPAuRNZo9wluYZQcSVL9yWNzxapCrXlT9mXyr6CD5pgRLU/Cliv2m30AuPLq6vNK33XPbTamI7XenL3730R2Dx9aDDRi3fnqYrsiIXaNOAud6fNCA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GlLbdUhx; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52b912198f1so3691382e87.0
        for <bpf@vger.kernel.org>; Mon, 03 Jun 2024 15:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717454318; x=1718059118; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6K+BGd/sjVibNL1YxWnASTBR3LzmvEWN/LqVUKBH3Cg=;
        b=GlLbdUhxMOvfv07UbuQp52IzwdbLEpzUyMLKXMF+3Sd3FveyGQ9kiponRzzOcpMI6T
         emqgoJVIwu8WT9FqW+p07vqBAyXhgq+fwevyFcKUJiULsxWdobvwl8b48coCz7mCa9oe
         PdXEK+mV0+PmDWLF5beeySzOz0sai6fZmW68U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717454318; x=1718059118;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6K+BGd/sjVibNL1YxWnASTBR3LzmvEWN/LqVUKBH3Cg=;
        b=X9izMNibHD5ZL9/Y+tB2TZkWiEUUmQpzYj/HKqStlYzVtCLipqZLpjWFwYcg2Tjutt
         955vi3BxgjdUpvzVIym9ZRJ5qSUD0SPQKAj+I29BnAlslxPikz3JRf+mfO6nFcQJ1itf
         YcJTfK4O1P6MSCcVuB1btkmOxxdXZBna0cgBzlnWmT9a+0c8HG7onpQCHt82Rejauhu2
         9mxwHNUHh7V43QZqHfSeMo3YELhhi6aNSvUcpT75H3Q0jvT85tcNCYNSARjW3xFT31kT
         fAfkIglOmoPOdCvyviAYDUm7h++gdRsC5cwRjouJ1fbWdQqlP6/kLgjZoZVg/G1k7hOo
         H5mQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIzU+KG4ulzlshel6dGYP5zuO5D6iRXeeUb4bxA+Czl6/1fnIWmDg+APIns3LC4I3PlVXfzzAbRi8kECfwKTSF4JT2
X-Gm-Message-State: AOJu0YxttMGb/XxXPWMDuF4d75kbtomK5bCs1OllC7qH+vPrUXHB/2bR
	Kh391LLN6PyjAKED25BlmloB5aJk718bz1i61JNiztuMO5mNbDLPd9ak+EF4VqVJ6hcVZRo1Usd
	+0ECeGw==
X-Google-Smtp-Source: AGHT+IFFZzp7YakYQzMcKRyznTbBTXhM3DT6k9ZuJ1RcvZ5Jy7rAm5DrduGWgsEH8biWNMvTccpIYQ==
X-Received: by 2002:a05:6512:3b81:b0:529:ecf7:29f1 with SMTP id 2adb3069b0e04-52b896d8ff8mr8433079e87.63.1717454318370;
        Mon, 03 Jun 2024 15:38:38 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b9181777asm867519e87.33.2024.06.03.15.38.37
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 15:38:37 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5295e488248so5125980e87.2
        for <bpf@vger.kernel.org>; Mon, 03 Jun 2024 15:38:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/SMsAn5zohdaQCLmAR4hQQVnh4aHYPGK2lnbhvJY4Lyj0Nj9mOEMp/MYAkJnJOtVuMIvirwz+njFs9/fzxCrq4ifa
X-Received: by 2002:a05:6512:159a:b0:52b:9f37:3ec2 with SMTP id
 2adb3069b0e04-52b9f373f5fmr1374809e87.11.1717454316895; Mon, 03 Jun 2024
 15:38:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602023754.25443-1-laoar.shao@gmail.com> <20240602023754.25443-3-laoar.shao@gmail.com>
 <20240603172008.19ba98ff@gandalf.local.home> <CAHk-=whPUBbug2PACOzYXFbaHhA6igWgmBzpr5tOQYzMZinRnA@mail.gmail.com>
 <20240603181943.09a539aa@gandalf.local.home> <CAHk-=wgDWUpz2LG5KEztbg-S87N9GjPf5Tv2CVFbxKJJ0uwfSQ@mail.gmail.com>
 <20240603183742.17b34bc3@gandalf.local.home>
In-Reply-To: <20240603183742.17b34bc3@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 3 Jun 2024 15:38:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg4WVUkXD1LMz2jFf9eY=p83SWSM0b4rcP34SshkgFoxw@mail.gmail.com>
Message-ID: <CAHk-=wg4WVUkXD1LMz2jFf9eY=p83SWSM0b4rcP34SshkgFoxw@mail.gmail.com>
Subject: Re: [PATCH 2/6] tracing: Replace memcpy() with __get_task_comm()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Jun 2024 at 15:36, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> It's actually a 4 byte meta data that holds it.

Ok, much better.

> Note, I've been wanting to get rid of the hard coded TASK_COMM_LEN from the
> events for a while. As I mentioned before, the only reason the memcpy exists
> is because it was added before the __string() logic was. Then it became
> somewhat of a habit to do that for everything that referenced task->comm. :-/

Ok, as long as it's an actual improvement, then ack.

            Linus

