Return-Path: <bpf+bounces-67005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48462B3C11B
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 18:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3A0E7BDBAE
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 16:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B223314B2;
	Fri, 29 Aug 2025 16:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IzyDEmsP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0808432C30B
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485744; cv=none; b=QVGTNI1X22nOYI6dRFmPSkQOZmxxrG4FB7AIrZ+bkxzyMqiBsI2wGWx680MO2BYNrY9CeonvRXJ+Dtiii9nfUiIrBRpJLkKMJNlyFQXdew6zr8MRX7DCEfPHM3VhxZbweph05yd1z00sCN79iFd13ZQ9pFc/vCejGIjMDs2hocQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485744; c=relaxed/simple;
	bh=upVsUuMpOdHRiGkETwVJlsIxvbf0n85rijqW3icJrTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l+5OxS0/492CjZGvhu+pXhws6f+ox4SROlTXFVgZpGzGE7RDiCNgFolLbEtrL4MNXo10CnXeVwGRUM5eYx63JV8EOZ21xHffNDh4+vH1/eNJXHAvO4V/hDH68+QwePA+gd5QkTwAXu4rkeDKZbrK7CgdECYYSOoUvmpC77g0tmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IzyDEmsP; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so325980466b.3
        for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 09:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756485741; x=1757090541; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pcseL9VLwiGrQMBX6gFapN6MvL8wsPhkJRSj/QHz9Rs=;
        b=IzyDEmsP8Wx0GgMVAkDSgVNa0wYZy1DI68rU/jpXhwCcnxGTNJ8kecW8VZ2aBFpoRr
         IM/eD7xkBHO7laL2HMa5JQAB5GbHW3cPMc5tIZlow5/EPLD71aq5CNyNwexu5cTysjyB
         JrUq3ioLNTO+RFHsp5AgRtFmOTJX+ipMGAR8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756485741; x=1757090541;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pcseL9VLwiGrQMBX6gFapN6MvL8wsPhkJRSj/QHz9Rs=;
        b=FTe3SOUNdlSx/UD4hu1ke+eEg1XsRN5PqI7brs4NM0EycIQba4NmcW23/izQboQpEK
         qT7fJxl9+Hi7XIseL/WZGbMpbpeHnGLDZIkave5dSyVfGmL5wPtB82JkxMZNApcGQUGN
         M6kYl53eY+CiCNUZwX1iN/DWZHVDwWCrnXcIWxoYiNBJLB8SXF+0V2Ldhay9JBT9zCXH
         j/BZ6ckl8XZKoSXbqdiQZwvjMR0I4GQbAAL14uYIWUVRmKweuN1MZnVjLei/8OeUDEpo
         Is4c0QM3CWX5dTc0TGLkOCHmxzpcMuy04CV67XBX282HBeOofAk7jh+O668JaNZsC1aI
         i40g==
X-Forwarded-Encrypted: i=1; AJvYcCWfKbt7XVLh6eP27u6UVyGZz5W5pU2WhzZtmArUfEy3hQQ7OQNlZDgOxgFaHETX/z6fTN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiY6mKZ3iIGAW78eeRxAGLflDUrEpRv2KUQJVzKW2uIjMdtsLQ
	F5efFcMeTDi1BOKFs6/EJFZduW2zPvIIh3xuBmeXhXOuoDOlnzFtuCHQvea02uZDwh5bkeOEbk4
	lbhBMlKwtJw==
X-Gm-Gg: ASbGncuS7Vwj9Kjb0If0aTyQDsDydBCGyVZFHKfstdsi8ISaMYJYp7oJfUNUkrDkF0B
	YZ/zcEwPgHg7OSa643Zt8B2lN5ltfKAEBECSu61Fs+DzRmPZtvIfrGd7X9ZOHDGBnSU83+v2L5u
	woTf3ozLfvbrKB62Em+XaNdYHAwr6PsXyd6dEfPP7ZW+VmCVC7vfen0CWUhOsOlRgP164PSh1gu
	iFvrLk1J5XOIxLrJroIq7kYIHyQvPoNFw7LibNg7s4rlFXHkGQgxY/DA2a15ryZszZo4P1rfIv7
	4tWh1vcOneqApgFsNF5rB/mt2yFvVtYx+Fbs4/vKR+pkUrYu5rwGutqnfZsH6rVlcAGA5KNcGsV
	21Nbk8TXyVDn0eM7CtHOFoNqk4EBWMaxRGqjMdc+69XucBTZvu+Nn3JrtjA2TZTI00xcIubQL
X-Google-Smtp-Source: AGHT+IHvG9RpyMtlvEtzPpzhLunK663qDSLUvHAaGRdjawTJw62s3ulyJnnKRvYFIBb/x9B7dudwFw==
X-Received: by 2002:a17:906:9fcb:b0:afe:b2be:6109 with SMTP id a640c23a62f3a-afeb2be6285mr1224924966b.59.1756485741230;
        Fri, 29 Aug 2025 09:42:21 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcc2d50dsm227655066b.93.2025.08.29.09.42.20
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 09:42:21 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb78ead12so376611966b.1
        for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 09:42:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXheagiKXZyKgh0cia6/zn76Qd+3PE0Z5QAknSiu/rDeAhF8NE0toKgWUSkq39Lof0jp3w=@vger.kernel.org
X-Received: by 2002:a17:907:9405:b0:ad8:9c97:c2e5 with SMTP id
 a640c23a62f3a-afe2875bfdcmr2604625966b.0.1756485740538; Fri, 29 Aug 2025
 09:42:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828180357.223298134@kernel.org>
 <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
 <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com> <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
 <20250828161718.77cb6e61@batman.local.home> <CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
 <20250828164819.51e300ec@batman.local.home> <CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
 <20250828171748.07681a63@batman.local.home> <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
 <20250829110639.1cfc5dcc@gandalf.local.home> <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
 <CAHk-=wjCOWCzXG7Z=wkbLYOOcqFbuZTXSdX2yqCCWWOvanugUg@mail.gmail.com> <20250829123321.63c9f525@gandalf.local.home>
In-Reply-To: <20250829123321.63c9f525@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 09:42:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgv11k-3e8Ee-Vk_KHJMB0S9J1PwHqFUv2X-Z8eFWq8mg@mail.gmail.com>
X-Gm-Features: Ac12FXyxaMJRB_uNJ16NrW9PwMVmli5CdBpfhgymWkTxGXIEdjwFXvJ_jKjFZ2M
Message-ID: <CAHk-=wgv11k-3e8Ee-Vk_KHJMB0S9J1PwHqFUv2X-Z8eFWq8mg@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@kernel.org>, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, 
	Sam James <sam@gentoo.org>, Kees Cook <kees@kernel.org>, "Carlos O'Donell" <codonell@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Aug 2025 at 09:33, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I just realized that I'm using the rhashtable as an "does this hash exist".

The question is still *why*?

Just use the hash. Don't do anything to it. Don't mess with it.

> I could get the content of the item that matches the hash and compare it to
> what was used to create the hash in the first place. If there's a reference
> counter or some other identifier I could use to know that the passed in vma
> is the same as what is in the hash table, I can use this to know if the
> hash needs to be updated with the new information or not.

No such information exists.

Sure, we have reference counts for everything: to a very close
approximation, any memory allocation with external visibility has to
be reference counted for correctness.

But those reference counts are never going to tell you whether they
are the *same* object that they were last time you looked at it, or
just a new allocation that happens to have the same pointer.

Don't even *TRY*.

You still haven't explained why you would care. Your patch that used
inode numbers didn't care. It just used the numbers.

SO JUST USE THE NUMBERS, for chissake! Don't make them mean anything.
Don't try to think they mean something.

The *reason* I htink hashing 'struct file *' is better than the
alternative is exactly that it *cannot* mean anything. It will get
re-used quite actively, even when nobody actually changes any of the
files. So you are forced to deal with this correctly, even though you
seem to be fighting dealing with it correctly tooth and nail.

And at no point have you explained why you can't just treat it as
meaningless numbers. The patch that started this all did exactly that.
It just used the *wrong* numbers, and I pointed out why they were
wrong, and why you shouldn't use those numbers.

          Linus

