Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A136A11F1DA
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2019 13:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbfLNMuY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 14 Dec 2019 07:50:24 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58264 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725809AbfLNMuY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 14 Dec 2019 07:50:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576327823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SFJ+JVZh68kf5Bo3hbR3mNNs21dIVdglZ0+Q/a3JWrA=;
        b=FeMimfpK2C6L8aYeKukBUBo/cQInV7KgOTjIEgegaQsUKdycrRo1SZbnrbCMXRA69I/Uqc
        31jjbA+pOk766KOL7J7dIue44goKyZmr+gf6mhFcUxMftMJ5BUUjIRNC1IdwnecDwGrYGS
        pcxHAe1NdlSA2Qra2chqtjHqVxoqsOw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-1GGytWzSNXqrvAHIO-TzhA-1; Sat, 14 Dec 2019 07:50:22 -0500
X-MC-Unique: 1GGytWzSNXqrvAHIO-TzhA-1
Received: by mail-lj1-f200.google.com with SMTP id r14so568390ljc.18
        for <bpf@vger.kernel.org>; Sat, 14 Dec 2019 04:50:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=SFJ+JVZh68kf5Bo3hbR3mNNs21dIVdglZ0+Q/a3JWrA=;
        b=UxE+QnhXuZ6NgQlrzryHQyT1mSx854ginMnyNiYZcScb3bQbPlu04VZntY47FlG/iE
         D2wQnUQf+gySAOrjnM8QlSm7l6QUrS+z+DvMm95WfvwXw/tAqdg+PaNYl3A4fm3oIHdf
         8fAj8360hsODqay1Il7d8/3sWFOOSj40/fkmUQ2UAMuJlXEbd5B3FjK8GUyKO0MKVhs3
         1fJurjoAZPvzR963IFfjGsAjnRZvlPyTMtL4T6gAql8Ekf4/Rz2C3uG9Da9j8ZnxupLw
         8hWvFckZZu4cEPXIWeUKV/PgGEbPEnAvD4yPiJlvLH3EBYNN4Dd1AiGYUSev+2mS60Y/
         Iy/A==
X-Gm-Message-State: APjAAAVKYc438ma1qMvgMbdjtarJZ/SVgni8BX8whn3Pqchsc4O9mz5e
        i1v4f2JCn+rtMMp6WNcFPSvJx+6MgMTieeq7wXcFR3q86MpI+BCQI+TFnN8bF/oHLVt6+mPkTDJ
        61N0NUqoKU6Ro
X-Received: by 2002:ac2:46c2:: with SMTP id p2mr10276409lfo.139.1576327820532;
        Sat, 14 Dec 2019 04:50:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqwvp0D/WOhsOaef++AzK+1abUCynFvfI+cueLmssQXL2aHLZSB34S5U/6RQhtGATfCbSDRr7Q==
X-Received: by 2002:ac2:46c2:: with SMTP id p2mr10276403lfo.139.1576327820372;
        Sat, 14 Dec 2019 04:50:20 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id e12sm6644826ljj.17.2019.12.14.04.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2019 04:50:19 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A61C5181A44; Sat, 14 Dec 2019 13:50:18 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com, daniel@iogearbox.net
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH v4 bpf-next 2/4] libbpf: support libbpf-provided extern variables
In-Reply-To: <20191214014710.3449601-3-andriin@fb.com>
References: <20191214014710.3449601-1-andriin@fb.com> <20191214014710.3449601-3-andriin@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 14 Dec 2019 13:50:18 +0100
Message-ID: <87a77vcbqt.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[...]

> +static bool sym_is_extern(const GElf_Sym *sym)
> +{
> +	int bind = GELF_ST_BIND(sym->st_info);
> +	/* externs are symbols w/ type=NOTYPE, bind=GLOBAL|WEAK, section=UND */
> +	return sym->st_shndx == SHN_UNDEF &&
> +	       (bind == STB_GLOBAL || bind == STB_WEAK) &&
> +	       GELF_ST_TYPE(sym->st_info) == STT_NOTYPE;
> +}

Will this also match function declarations marked as extern? I've
started looking into how to handle this for the static/dynamic linking
use cases and am wondering whether it makes sense to pull in this series
and build on that?

-Toke

