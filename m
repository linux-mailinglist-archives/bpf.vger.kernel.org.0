Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A71F2147CB8
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2020 10:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388342AbgAXJyF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jan 2020 04:54:05 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36743 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388339AbgAXJyE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 24 Jan 2020 04:54:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579859643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kj9LFbCnEWlNmUswLahnvJmujUVg7he2BqdXZV1Y5Fk=;
        b=eNg6tnSD2+Zi/9b0BEzWAjUoSOSWUn9Y9rrVEyPtXapuwzDwCkzIyPDjF5sxMoFnO52pUA
        F20MVeNS1pES4riqQ17btby9RR1zCvAu/nhRtUbsuDfXn7WkN+ISbCFxUsg4PXKgxFOv4W
        FeV4L+g78kQZKSqlrP50CuJIjGfa7Ps=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-oSdFGQASN1WYfvWyf5V2Ow-1; Fri, 24 Jan 2020 04:54:02 -0500
X-MC-Unique: oSdFGQASN1WYfvWyf5V2Ow-1
Received: by mail-lj1-f198.google.com with SMTP id z2so496726ljh.16
        for <bpf@vger.kernel.org>; Fri, 24 Jan 2020 01:54:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=kj9LFbCnEWlNmUswLahnvJmujUVg7he2BqdXZV1Y5Fk=;
        b=l+ETbKnHAurQ2p9/EMSlxEI9phA/ORWQJK5XVa8oUt+RqTWt4jxvbdniD9sD6pNp8S
         NIrJDblcTCKMJgzcnPqD3ulCHmbjzFk9k9M09BMtF2bS5P3NYmtQeEZfnKyqQ0avqjeS
         V4YsBbd32mq5sMBQwd4tmCbOG0IfHFk0byb/0eZrIaPVgeKlftei+rGkdahEkLKj0LAv
         VdQ1dnXqb+vROlaTQ9mvJc+Ulr0EPc2GqQMB3JRikKIjASggK5ckj+hJsDZIvBwQgd89
         lrNIEB1z0yV92EAfubB4N+5d4AKgdFDM/5XmKAejVvEIP+Ku34UK7kvV3YrvA8GDMppg
         0qTg==
X-Gm-Message-State: APjAAAXitexKDkgzjC74ULrWQkbBp8Nrr+sRSQnWp/hllfWcx14JiW+Z
        ywKwF+zheGvxMSkIV2Bqzl97KdsdEHtuOIVfVVEi2f6ZtOCnSYPcNdVa6DwZMXTIppbyZ18APaX
        F/2h4hH3GcV4J
X-Received: by 2002:a2e:87ca:: with SMTP id v10mr1635759ljj.253.1579859640859;
        Fri, 24 Jan 2020 01:54:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqzftReY65v+672gLoSlrbrdhqxQDfkSaIpLZLXpA465IVjPRlYrI26vbajFIoCoQGQMUjPZng==
X-Received: by 2002:a2e:87ca:: with SMTP id v10mr1635752ljj.253.1579859640716;
        Fri, 24 Jan 2020 01:54:00 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([85.204.121.218])
        by smtp.gmail.com with ESMTPSA id i1sm2743068lji.71.2020.01.24.01.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 01:54:00 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 705BF180073; Fri, 24 Jan 2020 10:53:59 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com, daniel@iogearbox.net
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH bpf-next] bpftool: print function linkage in BTF dump
In-Reply-To: <20200124054317.2459436-1-andriin@fb.com>
References: <20200124054317.2459436-1-andriin@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 24 Jan 2020 10:53:59 +0100
Message-ID: <87tv4lgoy0.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andriin@fb.com> writes:

> Add printing out BTF_KIND_FUNC's linkage.
>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

