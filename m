Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94F198F2D3
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2019 20:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbfHOSJd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Aug 2019 14:09:33 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:35649 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729210AbfHOSJc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Aug 2019 14:09:32 -0400
Received: by mail-qt1-f172.google.com with SMTP id u34so3306022qte.2
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2019 11:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=87jBvrmfDVMJVf8IFXwudV0aE/EPj/3YMYd29VW+nMY=;
        b=IvRqyQ9NRAPXdhdw51EW/7znw/89AZU4aBT7DiVUuRzt2oOGcUXdbwM9ONHgQJRyhc
         EdEg0mGP+LuTEpnyOdqLNgc3yTxFfUQDuaQ1w0Aq1kdMCmO1Muv8sNRdyqjtHmvU9hR0
         9E31gMw85Ocfip1u5lNZLBqrrYWghlMWBZvlspStGsoylXEdbxkdwnBjpKNmSS/D34AI
         Sd8WhAVmnKqB+/VB1bJJJSCPSJlbIbYS/RnDvwKiceyiBUPZorh4kJYU1krN7hq3nvh1
         OOJuqW1T65ugDkKnnxHlkVHOT3Q2GJ+zJayTyND/4iWRJwGF+VKeJ2D/jb1QPirL9QOE
         D8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=87jBvrmfDVMJVf8IFXwudV0aE/EPj/3YMYd29VW+nMY=;
        b=ALZ5jCSam2TjiKUalZMZ/2RsW6P2dBXrm0Y3OLBw8QSwyk/H7dX77VE882o0w5Gwil
         /IYwOnovv+CTJ066gd7925BFbOgxbHurJMYAybhFbdoeJ5QN/UAefAHccgsOAHDflzfk
         eK6O3rrz8LTH2TR63OGvwfV1j6WAbVD++QLOyI9R8p90zCAJ772QKpj/cM09eLUIlBzb
         iH6VGtbBo/lSvVyqDgw/RH7mOoV/7rchbGJhR6CjPaDwn+DA3OyBhSQLJhMc6SaHVnSw
         lD2CdeQUcf8teKnz84ICL5FjcM2SaiRNm/wc9Ku9cHjo9yawPER5pGhPZXNq83ts5eAC
         Kabw==
X-Gm-Message-State: APjAAAULzn5h/UgANjv2Yqyp1Ugmj3oPLuNrjqFkEwx7FlvaSOh423AP
        3hkI5WXiz8rqGyaXDZVFlq2gkQ==
X-Google-Smtp-Source: APXvYqzY+EzedYrrJaqdBRpkDq6DhPLiHEeO7o/fqWibnXpA0LiDH8jwwZyaFeiicKLJFUB5KO7frg==
X-Received: by 2002:a0c:9782:: with SMTP id l2mr4258555qvd.72.1565892571732;
        Thu, 15 Aug 2019 11:09:31 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id c11sm1583943qtq.41.2019.08.15.11.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 11:09:31 -0700 (PDT)
Date:   Thu, 15 Aug 2019 11:09:17 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Quentin Monnet <quentin.monnet@netronome.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        oss-drivers@netronome.com
Subject: Re: [PATCH bpf] tools: bpftool: close prog FD before exit on
 showing a single program
Message-ID: <20190815110917.657de4e3@cakuba.netronome.com>
In-Reply-To: <CAEf4BzYL-pJ79nKywsAH1b2S-EP_4SUZY5jS2wzYJ32pywsyrw@mail.gmail.com>
References: <20190815142223.2203-1-quentin.monnet@netronome.com>
        <CAEf4BzbL3K5XWSyY6BxrVeF3+3qomsYbXh67yzjyy7ApsosVBw@mail.gmail.com>
        <20190815103023.0bd2c210@cakuba.netronome.com>
        <CAEf4BzYL-pJ79nKywsAH1b2S-EP_4SUZY5jS2wzYJ32pywsyrw@mail.gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 15 Aug 2019 11:05:16 -0700, Andrii Nakryiko wrote:
> > > Would it be better to make show_prog(fd) close provided fd instead or
> > > is it used in some other context where FD should live longer (I
> > > haven't checked, sorry)?  
> >
> > I think it used to close that's how the bug crept in. Other than the bug
> > it's fine the way it is.  
> 
> So are you saying that show_prog() should or should not close FD?

Yup, it we'd have to rename it to indicate it closes the fd, and it's
only called in two places. Not worth the churn.
