Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3269F146944
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 14:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgAWNiS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 08:38:18 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45550 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728709AbgAWNiR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Jan 2020 08:38:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579786696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h6uD+1e68gi91qvBrZ/lqf2TnuTpmHDoEyL/oCZyo6k=;
        b=b+rpdp29lwZB58ZRemVOZMHijjNH1pUPuBEnq1JUA+xt/XFGutQAACZv2JkETUJ78YErEX
        xiklm7JejnYKdOe87SfXLP8a30p8CoVFs5FUwmlhH+X0f2ZmZu2oX2IM8PBwFwu+Jy4kcH
        N3WJxSfMgVAbH7YHzt4/Q3+oH85qLXQ=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-kulqfWSdPP-lg6iqT340Yw-1; Thu, 23 Jan 2020 08:38:14 -0500
X-MC-Unique: kulqfWSdPP-lg6iqT340Yw-1
Received: by mail-lj1-f197.google.com with SMTP id b15so1085752ljp.7
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2020 05:38:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=h6uD+1e68gi91qvBrZ/lqf2TnuTpmHDoEyL/oCZyo6k=;
        b=B3nq1y+3Ke8tG/akBj2Nn3gFCfPPVAYsXYw7nDnXsCqUr/h7GOXCS00TNgVBcHJHMn
         Z9Vpoc7NoHhDfIXRV9flCgpit7Wt5YLCpF7C1oh9Zn+VwhvbDmwMmJ34yiOyM8gF93Pg
         sSs2iJXy/3j+pXM8s/1x7JKvkQTmhdGBfjf8jgETXFLiPDzkuapTYFIAKipmBOXUQbKv
         JIZY/qFR1On79DAld7eARyzgpbKfDNi43rS3vo3urqkC8LHhwnVtU9H1EE3PURLVo/zb
         al3WsQqEBWt6to87ltp/nLJAiAXdRvQ59VzY3dXjqy9XGva30BFAyGLHwn3SORQn1eyy
         sAbg==
X-Gm-Message-State: APjAAAV68Pv5cM8JwTlS1tG7tii+mJ8fESp7+CqVCZBP8kawN1/PyOrg
        tcYEIWPpA3yWqeZD4c3VVeSnitLTDzVaH2SF5sOQK1/iwiVIekTCNPm8ZI03N60UOP7qB60BvH9
        Es+vccMWUVICa
X-Received: by 2002:ac2:50da:: with SMTP id h26mr4787282lfm.80.1579786692704;
        Thu, 23 Jan 2020 05:38:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqy4BWaWs+3H0Frdse6iV+jJqbBxUwLv0Dvg8acnZgByftBSE4MEGvlY+Jnho0dUBWe823FHAw==
X-Received: by 2002:ac2:50da:: with SMTP id h26mr4787274lfm.80.1579786692511;
        Thu, 23 Jan 2020 05:38:12 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([85.204.121.218])
        by smtp.gmail.com with ESMTPSA id s4sm1309808ljd.94.2020.01.23.05.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 05:38:11 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id F36231800FF; Thu, 23 Jan 2020 14:38:10 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Amol Grover <frextrite@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Amol Grover <frextrite@gmail.com>
Subject: Re: [PATCH] bpf: devmap: Pass lockdep expression to RCU lists
In-Reply-To: <20200123120437.26506-1-frextrite@gmail.com>
References: <20200123120437.26506-1-frextrite@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 23 Jan 2020 14:38:10 +0100
Message-ID: <87d0ba9ttp.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Amol Grover <frextrite@gmail.com> writes:

> head is traversed using hlist_for_each_entry_rcu outside an
> RCU read-side critical section but under the protection
> of dtab->index_lock.
>
> Hence, add corresponding lockdep expression to silence false-positive
> lockdep warnings, and harden RCU lists.
>
> Signed-off-by: Amol Grover <frextrite@gmail.com>

Could you please add an appropriate Fixes: tag?

Otherwise:
Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

