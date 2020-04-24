Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340DF1B734D
	for <lists+bpf@lfdr.de>; Fri, 24 Apr 2020 13:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgDXLkZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Apr 2020 07:40:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32195 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726707AbgDXLkY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Apr 2020 07:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587728423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SWZ1+8++HCeLZRs7dW4H8lydDzVCFKNZ/YDYwbv9WFc=;
        b=Fh3SnTvoRKHbaMWybXtbCBndaGp3qBh4xWnW/gsRGBP9Ctf4L6S3y/oVspwiX52b73Mkrc
        6L72ka0p1cqmDs4iXHzmm+X71ncj9Th3+NgfiEVkVkD7Mp6KiDVUIKvVXZ1sfETaFDBzpU
        1E77xL7eWhXPAOCvZawoUjzjgw15qio=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-nz7XvrKPOPW7mRe_GLZb5w-1; Fri, 24 Apr 2020 07:40:20 -0400
X-MC-Unique: nz7XvrKPOPW7mRe_GLZb5w-1
Received: by mail-lj1-f199.google.com with SMTP id c20so1722272lji.10
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2020 04:40:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=SWZ1+8++HCeLZRs7dW4H8lydDzVCFKNZ/YDYwbv9WFc=;
        b=LJsExO+dL2BLRKRaTg4NIH0+tiKlxFzWpHKEK54eYvmDGothSs0R8Gmt8entwupwg5
         tcAKSbUq/uA1mNTFtiRPZqaNQn0N+r35puHlBTyononFRPl03aKCyfIF/tjIx2U0mrU+
         ojgPj82Vg8ALOG29C9deEuCWirf9+kmemx6cVz3GEKOTLGKcE5jexsKNkYbyQojsutaH
         mVMOy6fhsgXz4lYu7rfCYsd/Qnjcb6TBHk7T5Ik3yHP3Sj1JV2FTz28x8R78SEVBuMX4
         wM4g6zb1feaiD8S7Or9VW+XitjQ1aQZJvufW2Y6eitg3WYNXik3UpsY0qX/zAUmERvHc
         0uSQ==
X-Gm-Message-State: AGi0Pub/eVVONTjm+/S+GjlZ0TQ+zCu8CGjvpzImF/CG4gcjKu8j3tbL
        ILN+1qvFBdJ9pGICiIg99tniG7n5i//Ndb4s0p69ML3TLo+o0Zc9cgILpERUFen/Fo4Dyo5ehEO
        NT8L+mxRpHxab
X-Received: by 2002:a2e:593:: with SMTP id 141mr5398743ljf.271.1587728418524;
        Fri, 24 Apr 2020 04:40:18 -0700 (PDT)
X-Google-Smtp-Source: APiQypIQZNpneb3kebTL2SDME7wq525YBjp1hgEf/Tc9yA0gnoqdxk1TPntfGJsmXk04XCBKhMauEQ==
X-Received: by 2002:a2e:593:: with SMTP id 141mr5398732ljf.271.1587728418265;
        Fri, 24 Apr 2020 04:40:18 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id s7sm4344285ljm.58.2020.04.24.04.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 04:40:17 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0190E1814FF; Fri, 24 Apr 2020 13:40:16 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com, daniel@iogearbox.net
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH bpf-next 00/10] bpf_link observability APIs
In-Reply-To: <20200424053505.4111226-1-andriin@fb.com>
References: <20200424053505.4111226-1-andriin@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 24 Apr 2020 13:40:16 +0200
Message-ID: <87sggt3ye7.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andriin@fb.com> writes:

> This patch series adds various observability APIs to bpf_link:
>   - each bpf_link now gets ID, similar to bpf_map and bpf_prog, by which
>     user-space can iterate over all existing bpf_links and create limited FD
>     from ID;
>   - allows to get extra object information with bpf_link general and
>     type-specific information;
>   - implements `bpf link show` command which lists all active bpf_links in the
>     system;
>   - implements `bpf link pin` allowing to pin bpf_link by ID or from other
>     pinned path.
>
> rfc->v1:
>   - dropped read-only bpf_links (Alexei);

Just to make sure I understand this right: With this change, the
GET_FD_BY_ID operation will always return a r/w bpf_link fd that can
subsequently be used to detach the link? And you're doing the 'access
limiting' by just requiring CAP_SYS_ADMIN for the whole thing. Right? :)

-Toke

