Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC671B7BD5
	for <lists+bpf@lfdr.de>; Fri, 24 Apr 2020 18:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgDXQkF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Apr 2020 12:40:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52709 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728019AbgDXQkF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Apr 2020 12:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587746403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YP5fQIfakK3kVOUysWonSyI4ix0kqSe5LjhdeJGKKbg=;
        b=KAq1EQAWC0N0sz8DNZGbzeIlltwtbn1cfjp6oN/aBndmOLOgOFDvnEavBkJkjQH81Lu0X+
        yLHTcedXqsKLR9spr2iLn46pU4Pb9UqPZ1WHopxKHVmMBP6ctvUpXsU4hWJ1+IwnCNTYi9
        AwH2l011cVPQRm5gg5p69dChl8dIWTY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-42g0JlRrNCiSHWNVv-C5Rw-1; Fri, 24 Apr 2020 12:39:52 -0400
X-MC-Unique: 42g0JlRrNCiSHWNVv-C5Rw-1
Received: by mail-lf1-f71.google.com with SMTP id l6so4207628lfk.2
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2020 09:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=YP5fQIfakK3kVOUysWonSyI4ix0kqSe5LjhdeJGKKbg=;
        b=CwVcVZyXN4/+OJ0cNegPebB/ZzhNbTUF5gzh0DPa8fF5srI7fC92zjDQ/9kNy5sxNP
         kYEGH2u8aGB4N24djZ/jDoWiCcWnaK0nQV2aA3d36udFzVHjf7wUL4Z4cpx19LsUSrFq
         4IbLPIaG8Ga1YDE6qVEN4whSqdKp1Qf8+ZroplxlXg8JzgbkPrz5ioaPMSLG9Xj9JYxn
         0H0W11fz7gyUc7xj/b2J0/bJ8+R6D472yRweeVNtKRdoq+eBtuiysFNHzrFtuOlFaqIq
         VXJrqTo906eeFIxxXpM3sM/xUC5wtoEUSONpsa+WoXplv0q5pkQ3eKhO3YrRdIFPa0C9
         +opg==
X-Gm-Message-State: AGi0PubQZwdO29t7Rc+om6l55YCBYT/F6wdPZby3DC+9eJqlDTIeipKl
        9hmYN97epK6GEkad9H35q2LN/NMIkFogwoi1YVz/7ws0WuQvY2ubjn7NjhdaVGrRuBwlzgK+0nD
        qTcPzAFFW0BXw
X-Received: by 2002:a05:651c:2002:: with SMTP id s2mr5969536ljo.285.1587746390531;
        Fri, 24 Apr 2020 09:39:50 -0700 (PDT)
X-Google-Smtp-Source: APiQypJjKm8cKsu77YxDHqoUMjAgTZDpwBduorMR+Ez/MNqw2eiSYRbuibCVxz0MW7sPJv0dXLcMRw==
X-Received: by 2002:a05:651c:2002:: with SMTP id s2mr5969519ljo.285.1587746390268;
        Fri, 24 Apr 2020 09:39:50 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id c2sm4763872ljk.97.2020.04.24.09.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 09:39:49 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 916201814FF; Fri, 24 Apr 2020 18:39:48 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 00/10] bpf_link observability APIs
In-Reply-To: <CAEf4BzYFj_DcTkc6+cQ8_uoxw0Aw4f9E-YhFJpY4Ak+B8=Y1Sg@mail.gmail.com>
References: <20200424053505.4111226-1-andriin@fb.com> <87sggt3ye7.fsf@toke.dk> <CAEf4BzYFj_DcTkc6+cQ8_uoxw0Aw4f9E-YhFJpY4Ak+B8=Y1Sg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 24 Apr 2020 18:39:48 +0200
Message-ID: <87imho3kiz.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Fri, Apr 24, 2020 at 4:40 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Andrii Nakryiko <andriin@fb.com> writes:
>>
>> > This patch series adds various observability APIs to bpf_link:
>> >   - each bpf_link now gets ID, similar to bpf_map and bpf_prog, by whi=
ch
>> >     user-space can iterate over all existing bpf_links and create limi=
ted FD
>> >     from ID;
>> >   - allows to get extra object information with bpf_link general and
>> >     type-specific information;
>> >   - implements `bpf link show` command which lists all active bpf_link=
s in the
>> >     system;
>> >   - implements `bpf link pin` allowing to pin bpf_link by ID or from o=
ther
>> >     pinned path.
>> >
>> > rfc->v1:
>> >   - dropped read-only bpf_links (Alexei);
>>
>> Just to make sure I understand this right: With this change, the
>> GET_FD_BY_ID operation will always return a r/w bpf_link fd that can
>> subsequently be used to detach the link? And you're doing the 'access
>> limiting' by just requiring CAP_SYS_ADMIN for the whole thing. Right? :)
>
> Right.

Great! SGTM; thanks for confirming :)

-Toke

