Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061BC417918
	for <lists+bpf@lfdr.de>; Fri, 24 Sep 2021 18:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343489AbhIXQuu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Sep 2021 12:50:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27752 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238886AbhIXQuu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 24 Sep 2021 12:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632502156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=+WjYnmvErdRs8r/Qp3drDnA8o8zNqDOAQo1ud4aKaOs=;
        b=QDetx+DFbCGOKx1MsBUM57TKlbJ67PfvnAeYLQlN9TaaKTRkj/3aO2lGet4vfJEbs0T6xr
        2SI1SiHd8K1XqlEdQzSOhoLIHWmmjpABQtdRf2C0hJIW1Szft+ZROSmiIdpuf2/L75bE2U
        X/h+juB7IZp+dxtbEaMs+Mo+wXdH30M=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-QzKL8d8EPA2m6gOkpbzwng-1; Fri, 24 Sep 2021 12:49:15 -0400
X-MC-Unique: QzKL8d8EPA2m6gOkpbzwng-1
Received: by mail-ed1-f70.google.com with SMTP id c36-20020a509fa7000000b003da5a9e5d68so129417edf.15
        for <bpf@vger.kernel.org>; Fri, 24 Sep 2021 09:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
        bh=+WjYnmvErdRs8r/Qp3drDnA8o8zNqDOAQo1ud4aKaOs=;
        b=4pQ/eSqblhQtDKsyBqQ5zZgxVnYVS8bXsS5+gAWKudBNKEkTIg1z2XCWW2nLlhrO1b
         7ziTOz6tqAi/T4lfd1knvFibmmMzom5z6FoVPqfMUAKUGxUt7My1/C7RTpH+EYSIAWWj
         xHKFhfee/8W3JD/sFpWzggn00QJOPUN533oycgkeeasguxj4NF8rmOh//bDyOjyu0JWQ
         JT8tjrHOood/A4ar6eIvq+jwQkgQCYdxZ3pA/uULIf5FBRVrVBnQyszOuCxs8a004Hkv
         kbNgQQE6tGcfELJZXsjqD475AJMJgNv1s2Vp9dIP5ZUCZF5so8Tvv+SD90RLxBpYa53B
         PRAQ==
X-Gm-Message-State: AOAM532mHJZI563N7oz/VSQm9UfXgqL/yignz83jEy/W6CybZRwcFeQp
        SF7NUYcIiFuENlpPYXkh6ZWgxVDSH2XLnf4A/UlF0pdDCStmOPuQopnUWP4cNCsgrBXD9k+D4bY
        AJdRp0hee97aZ
X-Received: by 2002:a50:9d0f:: with SMTP id v15mr5964748ede.275.1632502153088;
        Fri, 24 Sep 2021 09:49:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcUfQMgJK2R9W7sQULwBbJON70ZkqGl1b8xTp2fAFdUxz4y3HbS3TAXJVp/3xIb8nJ+GT9yQ==
X-Received: by 2002:a50:9d0f:: with SMTP id v15mr5964624ede.275.1632502151929;
        Fri, 24 Sep 2021 09:49:11 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id f21sm5196614ejc.18.2021.09.24.09.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 09:49:11 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C93DD18034A; Fri, 24 Sep 2021 18:49:10 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Jiri Benc <jbenc@redhat.com>
Subject: Reason for libbpf rejecting SECTION symbols in 'maps' section
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 24 Sep 2021 18:49:10 +0200
Message-ID: <87wnn5yl4p.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Andrii

We ran into an issue with binutils[0] mangling BPF object files, which
makes libbpf sad. Specifically, binutils will create SECTION symbols for
every section in .symtab, which trips this check in
bpf_object__init_user_maps():

if (GELF_ST_TYPE(sym.st_info) == STT_SECTION
    || GELF_ST_BIND(sym.st_info) == STB_LOCAL) {
	pr_warn("map '%s' (legacy): static maps are not supported\n", map_name);
	return -ENOTSUP;
}

Given the error message I can understand why it's checking for
STB_LOCAL, but why is the check for STT_SECTION there? And is there any
reason why libbpf couldn't just skip the SECTION symbols instead of
bugging out?

Hope you can help shed some light on the history here.

-Toke


[0] This happens because rpmbuild has a script that automatically that
runs 'strip' on every object file in an rpm; and so when we package up
the kernel selftests, we end up with mangled object files. Newer
versions of binutils don't do this, but the one on RHEL does.

