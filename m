Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A31D411E995
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2019 18:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfLMR5J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Dec 2019 12:57:09 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42010 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfLMR5J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Dec 2019 12:57:09 -0500
Received: by mail-lf1-f67.google.com with SMTP id y19so137079lfl.9
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2019 09:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=0ree+Xu8rZ7mkYTvWR/zpxVvZSVdBFxjnwqsdEhVoQE=;
        b=Olw5uaUjfLOeaLfOjA00de0/rop6f56eJdIxwk3KFcD5vf+zFxrESZgzYJmAe31ZY3
         isHAI11tdg9FtIKWgc9UV2SVgJhrcV0fx7i+3OMyf8xMMGxgbFoyaeLZswd2HRfHHkHc
         FEj6VOn7wafPnj5MjCSZu+9zk88kEA25yn9JPc0rn8XMXfBDg7o0a3A4FBIOPfcaYvm6
         5OoeqdfmdoEegwhPzh0fi+3kijBSdDH9cn4D04nEESZ+AUA/8E7eNBixnJjcX4U3WL8x
         54fqf8TCyzlzUrmB40idPHzb6xB6vefAY3Bob1o80jf/hPJejIDtV6PLG5P/svOMjmrI
         0XSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=0ree+Xu8rZ7mkYTvWR/zpxVvZSVdBFxjnwqsdEhVoQE=;
        b=SYBGITLwohcDyMkv/M521ziKA9Ri4h1hTNuiZaHRz24mFeiVL+jMcVQj+4iLD6uTsG
         rbabW0mf1u+kNZtOESXHSE/d8b/8Q+kslYnh9PTFC7SFrZTnDvPUvjVWMwto4Xj+Jbxt
         r946VhIHobRbFOA57r+Gnwa1JqzeKWKXERJbYvvCdPDIFKmrxmQ2b6aob4HYtrZz1rBl
         Ib9PnoO7gmFPWv8PWF2GAE7ENUbitLdLlBfGImanJpUJcjgtVuvBTr7xbQJCjpPn4+mx
         ILs4qkOO+okvNlf/5PQXsRDEjJsMDsLZE+yN4TSE3pjsi1PfTHvOT7sVGGmtzxXwOeLt
         PzAw==
X-Gm-Message-State: APjAAAXBlg9qOE1XfzAY1al1wiU3x8e4WB4XGhr4h3tXy5R7lmvlv1x4
        UgPLh5cCWnn7Wna19HSi21tLwg==
X-Google-Smtp-Source: APXvYqw2uRQCf5rheqlhTRCrB/4qF+5iOWFureszP3EXBqbU7WNe+g61qypwyWIcfWDXzPZHGqMVOQ==
X-Received: by 2002:a19:710a:: with SMTP id m10mr9520632lfc.58.1576259827860;
        Fri, 13 Dec 2019 09:57:07 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id u16sm5149692ljo.22.2019.12.13.09.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 09:57:07 -0800 (PST)
Date:   Fri, 13 Dec 2019 09:56:59 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Paul Chaignon <paul.chaignon@orange.com>
Cc:     bpf@vger.kernel.org, Quentin Monnet <quentin.monnet@netronome.com>,
        paul.chaignon@gmail.com, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH bpf-next 2/3] bpftool: match programs by name
Message-ID: <20191213095659.2782ca57@cakuba.netronome.com>
In-Reply-To: <20191213124038.GB6538@Omicron>
References: <cover.1575991886.git.paul.chaignon@orange.com>
        <1e3ede4f901a36af342e71bc4fdd2b27fbf9a418.1575991886.git.paul.chaignon@orange.com>
        <20191210124101.6d5be2dd@cakuba.netronome.com>
        <20191213124038.GB6538@Omicron>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 13 Dec 2019 13:40:38 +0100, Paul Chaignon wrote:
> > > @@ -176,7 +177,20 @@ prog_parse_fds(int *argc, char ***argv, int *fds)
> > >  		}
> > >  		NEXT_ARGP();
> > >  
> > > -		return prog_fd_by_tag(tag, fds);
> > > +		return prog_fd_by_nametag(tag, fds, true);
> > > +	} else if (is_prefix(**argv, "name")) {
> > > +		char *name;
> > > +
> > > +		NEXT_ARGP();
> > > +
> > > +		name = **argv;
> > > +		if (strlen(name) > BPF_OBJ_NAME_LEN - 1) {  
> > 
> > Is this needed? strncmp will simply never match, is it preferred to
> > hard error?  
> 
> I tried to follow the fail-early pattern of lookups by tag above.  

Right although tag does a scanf and if we didn't scan all letters 
we'd use uninit memory.

> I do like that there's a different error message for a longer than
> expected name.  Since libbpf silently truncates names, typing a
> longer name is not uncommon.

Ugh, I didn't realize libbpf truncates names. Okay, let's keep the
error for now so we can switch to truncation if users complain.
