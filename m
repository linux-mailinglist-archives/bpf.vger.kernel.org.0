Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBE22036AA
	for <lists+bpf@lfdr.de>; Mon, 22 Jun 2020 14:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgFVMZk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Jun 2020 08:25:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33618 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727852AbgFVMZk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Jun 2020 08:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592828738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gTNATydljRDXc8kpeNmwHEday5gWAyzDt0KL/m3GWgg=;
        b=RBfN/6AZl/JolQtpatn1ZlHVVTHLs6V6P1llnMMlIWic65zuA/Wqjs5J3fC3mj/19rJZN5
        YUEJbIIx9J/KSDc/ax3yLcdMUZst45MMJGGbsjj4TUOSRlsxpsjoFEy1oxHYXmdmIIWNaW
        r/PrMhyCHLd5+qvDv+JVitoaRsYkhtE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-Ehmdp5fJMR6XK9aNyOINOg-1; Mon, 22 Jun 2020 08:25:37 -0400
X-MC-Unique: Ehmdp5fJMR6XK9aNyOINOg-1
Received: by mail-wm1-f69.google.com with SMTP id p24so9273016wmc.1
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 05:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=gTNATydljRDXc8kpeNmwHEday5gWAyzDt0KL/m3GWgg=;
        b=eYVvl6afg+ou+pitPqxS3DyEqz2qF3+cTQUTdZKSshV4rkw2FUApEok4c6krTsNcrk
         g1wrrXKGfFxX8nmtolas3GYo3MUc+OdJ0ly1tsW/8uPszEc0SbOlIHny4IoLQTiEnjsq
         n3bAFkRQFKqhhHL39715HEozsNcPKN8R4L1AeHTuXReS6c4hj/GT9hWYd1vd2gEDeTsm
         z0K6/sLM4MkwIRxwCdPdlLdjoAwicwL+Rr+4nvWITO7BIIiFsfOTC61CgRu/HIcPvFo/
         K/u+lZatSCNDOSDbR+nedJEnT6X/Afs3Ob4rie06KNasIimFGnQcM4RiM5el8W1LPvzn
         fxRA==
X-Gm-Message-State: AOAM532FEcrMcHmCroS68++mfwqObkSsf17Uein5ofMpYIhNq21Av6u1
        K6u31Aqs2xBdHOm+RLRWsIrzzV29KGG3Y/dGbQj2oKWTjhVijGRdFoh53KuZj8DQbp/OapUF9Ie
        4KTfOHKPPNNwm
X-Received: by 2002:adf:82f4:: with SMTP id 107mr18606257wrc.163.1592828736267;
        Mon, 22 Jun 2020 05:25:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlW9JmXyeDhC/4XAHiKD+ODx7ZaqBmWyf3RIOEM2zaljWjq9f/EE5Dt+X9wT+tl2NekZO9Ew==
X-Received: by 2002:adf:82f4:: with SMTP id 107mr18606243wrc.163.1592828736064;
        Mon, 22 Jun 2020 05:25:36 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id k14sm17446948wrq.97.2020.06.22.05.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 05:25:35 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AAF3C1814F6; Mon, 22 Jun 2020 14:25:32 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com, daniel@iogearbox.net
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH bpf-next] libbpf: add a bunch of attribute getters/setters for map definitions
In-Reply-To: <20200621062112.3006313-1-andriin@fb.com>
References: <20200621062112.3006313-1-andriin@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 22 Jun 2020 14:25:32 +0200
Message-ID: <87zh8vthhf.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andriin@fb.com> writes:

> Add a bunch of getter for various aspects of BPF map. Some of these attri=
bute
> (e.g., key_size, value_size, type, etc) are available right now in struct
> bpf_map_def, but this patch adds getter allowing to fetch them individual=
ly.
> bpf_map_def approach isn't very scalable, when ABI stability requirements=
 are
> taken into account. It's much easier to extend libbpf and add support for=
 new
> features, when each aspect of BPF map has separate getter/setter.

+1, good idea!

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

