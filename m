Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80CEA1E6D1
	for <lists+bpf@lfdr.de>; Wed, 15 May 2019 04:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfEOCLr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 May 2019 22:11:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37561 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfEOCLr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 May 2019 22:11:47 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6so511709pgc.4
        for <bpf@vger.kernel.org>; Tue, 14 May 2019 19:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ibv2jL9MIE2sgOj/FSY9Qy78AuY52gxW/vTQ7rQM6Fk=;
        b=gI9s2mi2kqZ17JJAU0YoyIfLDFu+2syRFCX0PcWGrVbqriGw6DXmzUHyn9IaDpq51F
         QkalknJ73qhuVXIoQ3OYop8bI9IHuD/k8UTHtVnwRKM9i/qbhLx6X16Pgh2w/h/tJrB4
         WQ8ZywJndox3WFe/LOlg8pBZOp0XMThkWbjMbJ3OKB4wUyJ1iwq7noafjSZfv8n85zFa
         xkiUJV6l7MrSJg9PLaMETHsQB57UaJJAwo5GwMwy4dqD3vSSanRHRNZjpW+3YXea69kF
         bnhcMVzr/C0NBeVoBohxXwWaROo1A9IQ7fG+LEBcTnc+fWunyS8pBUWeWeMWfUP6NJDq
         41vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ibv2jL9MIE2sgOj/FSY9Qy78AuY52gxW/vTQ7rQM6Fk=;
        b=pQxavMT92K4fUjF+qKqhJg52f8FQ6A/w4PM4ZcLig0a97pd10FsC3NFTSYIbXlIkdX
         yYZPK1zCsqSz9Ko/W2FXTXzzlD4meuIqvRY5+ZJoaY9BPgeR+VUG9oRET1kGN5iYoKNZ
         fuP1oSPjd3qxJP1EtNLdVC/2IY7h1GGnKLJnBn9rprdDKPENDJZcqVrn8uE4H+ZIqvo1
         ZvpKvjpRay8zJv1xp10clUQI5/VzL3Ehi5WJ24Z8aWrb1Y6jZIcxtxVS+n1nOrfBJXZJ
         zDFS/SKZCyyzQ5Za3KQherfYVB6lekww64QEy3NbZ1A5YZNP2A1kQftFgGZ3q2UQCj5m
         w2zw==
X-Gm-Message-State: APjAAAUT78E3ZtJO9tAhs/t1uMLai7g5wm7mJsAjS92ZJMPsxQj+8SXx
        RVt1vulCcCMryUb9doS8PRTlnw==
X-Google-Smtp-Source: APXvYqyZTQ3ubd5b9rJuVurqt85U2CrOuonboMdcfLADKkX/csh7Tc5zPzRaCzT976ZIlo/f3lasFg==
X-Received: by 2002:a62:2506:: with SMTP id l6mr43641497pfl.250.1557886306571;
        Tue, 14 May 2019 19:11:46 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id c142sm550322pfb.171.2019.05.14.19.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 19:11:45 -0700 (PDT)
Date:   Tue, 14 May 2019 19:11:44 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH bpf 0/4] bpf: remove __rcu annotations from bpf_prog_array
Message-ID: <20190515021144.GD10244@mini-arch>
References: <20190508171845.201303-1-sdf@google.com>
 <20190508175644.e4k5o6o3cgn6k5lx@ast-mbp>
 <20190508181223.GH1247@mini-arch>
 <20190513185724.GB24057@mini-arch>
 <CAADnVQLX3EcbW=iVxjsjO38M3Lqw5TfCcZtmbnt1DJwDvp64dA@mail.gmail.com>
 <20190514173002.GB10244@mini-arch>
 <20190514174523.myybhjzfhmxdycgf@ast-mbp>
 <20190514175332.GC10244@mini-arch>
 <CAADnVQLAJ77XS8vfdnszHsw_KcmzrMDvPH0UxVXORN-wjc=rWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLAJ77XS8vfdnszHsw_KcmzrMDvPH0UxVXORN-wjc=rWQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 05/14, Alexei Starovoitov wrote:
> On Tue, May 14, 2019 at 10:53 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > Existing __rcu annotations don't add anything to the safety.
> 
> what do you mean?
> BPF_PROG_RUN_ARRAY derefs these pointers under rcu.
And I'm not removing them from the struct definitions, I'm removing __rcu
from the helpers' arguments only. Because those helpers are always called
with the mutex and don't need it. To reiterate: rcu_dereference_protected
is enough to get a pointer (from __rcu annotated) for the duration
of the mutex, helpers can operate on the non-annotated (dereferenced) prog
array.

Read section still does the following (BPF_PROG_RUN_ARRAY):

	rcu_read_lock();
	p = rcu_dereference(__rcu'd progs);
	while (p) {}
	rcu_read_unlock();

And write sections do:

	mutex_lock(&mtx);
	p = rcu_dereference_protected(__rcu'd progs, lockdep_is_held(&mtx);
	// ^^^ does rcu_dereference in the mutex protected section
	bpf_prog_array_length(p);
	bpf_prog_array_copy_to_user(p, ...);
	bpf_prog_array_delete_safe(p);
	bpf_prog_array_copy_info(p);
	bpf_prog_array_copy(p, ...);
	bpf_prog_array_free(p);
	// ^^^ all these helpers are consistent already with or
	// without __rcu annotation because we hold a mutex and
	// guarantee no concurrent updates, so __rcu annotations
	// for their input arguments is not needed.
	mutex_unlock(&mtx);
