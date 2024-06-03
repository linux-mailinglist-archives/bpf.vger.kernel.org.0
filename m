Return-Path: <bpf+bounces-31265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DEE8F9F77
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 23:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0DF1C2343A
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 21:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4E113C805;
	Mon,  3 Jun 2024 21:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N1eI4ZhZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808374F1EE
	for <bpf@vger.kernel.org>; Mon,  3 Jun 2024 21:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717450952; cv=none; b=hfvEOOZJ+tCN6iWhJ7pamNedhEHd1+FGzJV/9+6EIq/2kmqN+LeTPd8q5oEgkicpQ9hgh//y7wQSOs1FZ+xDIEHb8K33AIlLQiQacj09zMpZcrorI5A49v1ly+vBwPevyrM2Cmqv7JfX1bFOP1RCLWvDW8y4Aj300qEfPjiZSH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717450952; c=relaxed/simple;
	bh=t2+3hpTAkuvcywD1/Fq+cZAsXxs3N6zMjhMfwGrJHIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fd2ClzfMrCWQ0CJBGDDRxY3ms3zxnHvZ0DPZluubXNPBBJfBg/dCRxxb56+IYkLuyQelX1Mhvu31c00nCuOLsPudRWIN4AAuFBnDqaOTGb1vkbCy4S9Nv+umxiRLBieYll4RclMtneUbTX0Kw2UeouDfJ2KWZsZqhRQCQ8VJHBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=N1eI4ZhZ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57a68b0fbd0so1215673a12.1
        for <bpf@vger.kernel.org>; Mon, 03 Jun 2024 14:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717450949; x=1718055749; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R+C9bWbF6JQXXqqT/WHs93C1W49YzDnZgVk3vpecOx4=;
        b=N1eI4ZhZlPjf68UnhLGKgEctRtMjOntNIkVhWbizskPmuiRECFIehLROdwxyzTQ9AH
         S9cP0MBrkfaqe7srvrEyx01OYady8bCw+zGe0+e6RweNuBb176fwD8b5ZT0cNBTt5D0R
         vn7DjORx+6oRGzNKhQi4sA6ri3UvO20Z+ast4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717450949; x=1718055749;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+C9bWbF6JQXXqqT/WHs93C1W49YzDnZgVk3vpecOx4=;
        b=Re9Zns4xHK8XRUjV3hBFDnt79UN0qgzOYz94UasaijUJPMSKKv7M7BDIVFthORG4FW
         rVmdJTkirKlV5JwB/3/AhTv8zTtNR0ranP0id2o5iAgS36b3lVH6ZbWqub4YbgdVY9qn
         WqcLk7BRdYey6BFe3W3hV8RA+mE/iTV9k56drs4rQAv3H78ctnTtxV2HW+ksjnhDUSu0
         rMHcYCI5ORvIy39K/BQHkNAtWGZk6DIaqCm5S/ehImycVJaDq3nhDWJGs6a2PKuqfS0X
         1VfKK5ymPbDUHcm587YmL3GKq809Iljienz7CwViLg0WpHWJOAhkzjZ+aD+/ibqSvT0s
         Goug==
X-Forwarded-Encrypted: i=1; AJvYcCXL0vnBYbKVRtoRCFNOeYEABsjfcwZvWmjwndPQl8atb+ItOdvTtf1U7R87WM20syfTPDrxckJGiAuoPH1SvMub0mCG
X-Gm-Message-State: AOJu0YzWemD3VCDnzoxDR5C1PKitAwFvQ602Jk2tfkPxiEfvve76Fh3Q
	zURD37uukbxifj1kA9DZbBTtZwUY0s+xOSdA6OAUudpOIOcXMWhBryuEUVjmZ07Drr+ekXKTazc
	Nm9o=
X-Google-Smtp-Source: AGHT+IH+HufuGIofWRTqLRHy5c5PGQj24o2v8bqPp2iDdFneR7WHJgVQFMzjkSTnPD1fpZIP1ZekIQ==
X-Received: by 2002:a50:d518:0:b0:57a:4b31:5d71 with SMTP id 4fb4d7f45d1cf-57a4b3160f6mr4705635a12.26.1717450948595;
        Mon, 03 Jun 2024 14:42:28 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31b98e0csm5982083a12.13.2024.06.03.14.42.27
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 14:42:27 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a683868f463so434675766b.0
        for <bpf@vger.kernel.org>; Mon, 03 Jun 2024 14:42:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVV9bCc14POKRohDJpls6pvYq0/Fv5EkftWVtYflsrgPAVQybgx4EKTFnCVQ1iyWpjsmmdJfkGUilCIiUk4EKrrBRl4
X-Received: by 2002:a17:907:9482:b0:a68:c6c1:cd63 with SMTP id
 a640c23a62f3a-a68c6c1d466mr478691866b.13.1717450947222; Mon, 03 Jun 2024
 14:42:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602023754.25443-1-laoar.shao@gmail.com> <20240602023754.25443-3-laoar.shao@gmail.com>
 <20240603172008.19ba98ff@gandalf.local.home>
In-Reply-To: <20240603172008.19ba98ff@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 3 Jun 2024 14:42:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=whPUBbug2PACOzYXFbaHhA6igWgmBzpr5tOQYzMZinRnA@mail.gmail.com>
Message-ID: <CAHk-=whPUBbug2PACOzYXFbaHhA6igWgmBzpr5tOQYzMZinRnA@mail.gmail.com>
Subject: Re: [PATCH 2/6] tracing: Replace memcpy() with __get_task_comm()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Jun 2024 at 14:19, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> -               __array(        char,   comm,   TASK_COMM_LEN   )
> +               __string(       comm,   strlen(comm)            )

Is this actually safe is 'comm[]' is being modified at the same time?
The 'strlen()' will not be consistent with the string copy.

Because that is very much the case. It's not a stable source.

For example, strlen() may return 5. But by the time  you then actually
copy the data, the string may have changed, and there would not
necessarily be a NUL character at comm[5] any more. It might be
further in the string, or it might be earlier.

                  Linus

