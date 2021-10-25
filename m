Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6429F439596
	for <lists+bpf@lfdr.de>; Mon, 25 Oct 2021 14:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhJYMIt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 08:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbhJYMI0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Oct 2021 08:08:26 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC69BC061224
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 05:06:00 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id e10so21578838uab.3
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 05:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=CT/q+dlrfk5YNnSJ+9aKffida5ZW42IofveDiasWyRU=;
        b=G09zgxKFUiFcbfpASdxFrpn++jsiwz3ug4rIbqAMZ/Vb7yPy8YrP9bVuUU2qydyX+w
         k6HiJLOeKRltUauER05OGoYV2j9bqeIBzX2dUKgKL9GflY21P7wemIFDa4mSeNlCByYl
         LpbIfNHlZ7jO87L3eqq60SDcNn71KV8mZl3ci7aBKuzgtsFC6nnUVI15vNkD6I8hwcQJ
         VL5C9Lf1NEtyAjQXHaB508kEmXy4eVc9p/qSfeUYfCX1alOveQxRUshDYpNvSpRQf82s
         O66RvnRH+6TUt97pGi3OSZeak3udiUZAUV3Z5cMkemDNaSogQ9TXDnYpJ1iCc3gOaiA2
         oZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=CT/q+dlrfk5YNnSJ+9aKffida5ZW42IofveDiasWyRU=;
        b=cup7EEN9zX7cclGwd1nd1Ue71An3TcZsfdlA76Fxi7omEULjCGOz/v1oIY9KqxHUEI
         hwX7MHcZUOIiy6dsHIZ1Gu8ysNqNEH7cHbReN3DhuCX8/wPlipywYgt+NVuKo+C9iM9N
         T9ABgHBt3MZeR6c7l5+HnH1IhDLtjrppNYPmDc+mFvr9TWXX2XCZ/9Szb3L3jquuGZwC
         7e1YtrqvtsQrNeO3m9Ja93aI/ICj+rvm+JS31lkxeJ38rvke8qFJINfvVgRU4IOlKFiK
         um2lgjwz/rmaZLwkTK7a5l/NfW0ZnNBu78FppNkl+HPfQyiZvFQnYctvlvvArDkuL6zb
         3xvw==
X-Gm-Message-State: AOAM533MzKtWxHyFv3BM1WBQoEdma5vF4kV55JuHf9Ubrn5PUZyeU6Jx
        Z8lXiEdAX24lnwaUXHxVBy37S0FksJjNDGyh/EbnU/y3qA==
X-Google-Smtp-Source: ABdhPJwTGvxE/uXP1okHUnwSswj2OTyb2yc6pcYzySKyINA5jCK1dN4UF++0j2Vs0c8Yoh0ELPQeZb4Odn+mfKJybT4=
X-Received: by 2002:ab0:6e89:: with SMTP id b9mr14765567uav.132.1635163559622;
 Mon, 25 Oct 2021 05:05:59 -0700 (PDT)
MIME-Version: 1.0
From:   Tal Lossos <tallossos@gmail.com>
Date:   Mon, 25 Oct 2021 15:05:48 +0300
Message-ID: <CAO15rP=JzzanBC7Hj=9pshpMeWGJVpbt0wCiZfP8HwBaEbcFMw@mail.gmail.com>
Subject: Question regarding "BPF CO-RE reference guide" blog post
To:     bpf <bpf@vger.kernel.org>
Cc:     andrii@kernel.org, assaf.shab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello!
After reading Andrii's new blog post regarding BPF CO-RE, which was
really lovely and well written, I came up with a small question:
When you gave the example for BPF_CORE_READ, you've accessed the
executable pointer under linux_binfmt struct.
Is it a mistake with linux_binprm struct? or maybe I'm missing something.

Another thing, maybe you could add a little explanation about how
libbpf validates the structs offsets with the help of BTF? It's a key
part of CO-RE so it would be nice to have a little deep-dive in the
blog post about it :)

Thanks.
