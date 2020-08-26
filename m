Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228AE2529F6
	for <lists+bpf@lfdr.de>; Wed, 26 Aug 2020 11:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgHZJ0S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Aug 2020 05:26:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27452 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728063AbgHZJ0Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Aug 2020 05:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598433975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=agp/hO3HA0Z0hfUFtsmDs9RtARVSFqoaGKCQpLnO2Ok=;
        b=N3JpjTIMh+iF8460yynV+pLkmnMcPXdYwvu19bISB5HwlBZPmWa0piNz6Z5meC4FQ1dfhQ
        KomH+Kb/Ih9TdITv+90qXk7kCQ39nn4NCMohXWk98o/MtJjIK5J5zxn+ALU8SKG6ZP06vH
        FIJYIdSmxfHRNed6d9eyC6Sz7upxdCQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-96tLtoWZO1qmnPCf7vt_qg-1; Wed, 26 Aug 2020 05:26:13 -0400
X-MC-Unique: 96tLtoWZO1qmnPCf7vt_qg-1
Received: by mail-wm1-f70.google.com with SMTP id z1so532201wmf.9
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2020 02:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=agp/hO3HA0Z0hfUFtsmDs9RtARVSFqoaGKCQpLnO2Ok=;
        b=FpkIOpXgu2QM9LWwJZZu1YSsdu/GycUGvMUyypXz9mvmyW2phabNt2uUDnk2FtGhSI
         pEz1W8lS31wPZ5Vr2TWzEAsr6KW9oK+egZRM5fqVAwvA2SWtm2LccTk/8BZ3WulfcSZF
         TncKsY9c6v4tBt8vXpWDYjhDybxyDlqLdnHH+6F14yl+7LSLQWQYKlhf94DKfSwJwVPm
         oq6V0uvL3BYfTNQreutZmTHNJwZ3VUxrzC/+JCGQFQy2pTUfXb1NHl61j6DgDhQoVnNW
         juLYenR0g1MpKEXvaQn1zbDJ/NRflPpyOfVDAGcXLIvTKRRJMLnlHiAYjSAC3IYZKXxa
         8a4A==
X-Gm-Message-State: AOAM531Iz+mTqOzsu4uRO80ajrTdZt6+FNQuD9El9sU/oDb12qitlrhV
        SSpvu6kvG497PbzB24bD72yIB08mQacHzx+9CVMFbjaWnhtc6F6pYkI/NzsInojtxDu2iP8DmX3
        7IiwiljghkCxs
X-Received: by 2002:a1c:f402:: with SMTP id z2mr5905007wma.87.1598433972521;
        Wed, 26 Aug 2020 02:26:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjBNfA0JkDm5pSERTTkgDewo1suo1L4gWLGvbKyUyxju95Q1RgGFF9tew89G/0ciNae8pP+A==
X-Received: by 2002:a1c:f402:: with SMTP id z2mr5904993wma.87.1598433972345;
        Wed, 26 Aug 2020 02:26:12 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id j8sm4780813wrs.22.2020.08.26.02.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 02:26:11 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 638F2182B6D; Wed, 26 Aug 2020 11:26:11 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Udip Pant <udippant@fb.com>, Udip Pant <udippant@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 0/4] bpf: verifier: use target program's
 type for access verifications
In-Reply-To: <20200825232003.2877030-1-udippant@fb.com>
References: <20200825232003.2877030-1-udippant@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 26 Aug 2020 11:26:11 +0200
Message-ID: <87wo1lwyfg.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Udip Pant <udippant@fb.com> writes:

> This patch series adds changes in verifier to make decisions such as gran=
ting
> of read / write access or enforcement of return code status based on
> the program type of the target program while using dynamic program
> extension (of type BPF_PROG_TYPE_EXT).
>
> The BPF_PROG_TYPE_EXT type can be used to extend types such as XDP, SKB
> and others. Since the BPF_PROG_TYPE_EXT program type on itself is just a
> placeholder for those, we need this extended check for those extended
> programs to actually work with proper access, while using this option.
>
> Patch #1 includes changes in the verifier.
> Patch #2 adds selftests to verify write access on a packet for a valid=20
> extension program type
> Patch #3 adds selftests to verify proper check for the return code
> Patch #4 adds selftests to ensure access permissions and restrictions=20
> for some map types such sockmap.

Thanks for fixing this!

For the series:
Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

