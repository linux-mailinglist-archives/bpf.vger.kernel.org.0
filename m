Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2A5110A42E
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2019 19:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfKZSuu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Nov 2019 13:50:50 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54032 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfKZSuu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Nov 2019 13:50:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574794248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0r4KWfIOtxgISfApasmXgGWya0QXrhQe0FmvwJZ3LCk=;
        b=DbQjbtZ6dLNlWnrB7grb///Q7m7FnK0AuzaDMFidDT1GA0lGtTp+pq/aQ24OdYRs3vG859
        lczNQ/pj0g79+6fkvKIcMGS6Ctk3SAox9h3bzYn3ps0usg/jgv7VyicTL8/9wwomJDsYFu
        y0WvKrZy8dIm6ydDfjLSISfb5u5Ejgg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-_kPl75WCNZWpijKuOfgVWQ-1; Tue, 26 Nov 2019 13:50:47 -0500
Received: by mail-lf1-f69.google.com with SMTP id q13so3545466lfc.10
        for <bpf@vger.kernel.org>; Tue, 26 Nov 2019 10:50:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=oJf7PTKEEbEjo8GcSBfvuP8BlJ48R6NcwJ+kR4IpGyQ=;
        b=sUctx4LFxF0u+4uq0c4eRjXdqvySKerSynOYhJOgSCI4aPWvXeS6DOzHhUaKHgwlFt
         OjvwgGYtDTIPsgczIv0JzCWUOyXlfLofpm81KvFhCRu5+wwHxiRSeFoNa5/2AcQzfNCA
         7cjvDt79Qn8kquNlS1T/UTs4wdyzKLYJsjjkeQhsSvXYHxWsjm347TAVHt4HgXa5SdTY
         +t9ys8HHzyIALo1axtD/SZHhcr8qkgO/cVbtWjiFxF5AkyMeGr7mJFqXXHIxqK/yVREo
         iP54Ek+s7rEcmW8faOLg+R8bU+D1aOENo3gwemd+/HpAsk2RkZaLsPG6waj63FStz+JH
         DRMg==
X-Gm-Message-State: APjAAAW2baz5jrdQDk3Fll7iuNQN+Ftqo71hVKIFqcBwPdi89QglWwBW
        AnM/DmYfjHpeySSjM3wH6/8C1aRFlOqhw8SoWvN4sSzFAQ6y6zg1woDuZ91IWdPeGN/Y2QvlVJb
        aDtw297on/Rk0
X-Received: by 2002:a2e:a0ce:: with SMTP id f14mr28710576ljm.241.1574794246176;
        Tue, 26 Nov 2019 10:50:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqzHUc+oquSTaDm4CLKd9afrY/tGbnKn6DtP9DUe78i1wuycX8Rquk69fvv3hGcR7RNE9dzAcw==
X-Received: by 2002:a2e:a0ce:: with SMTP id f14mr28710563ljm.241.1574794245996;
        Tue, 26 Nov 2019 10:50:45 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id d24sm5904329ljg.73.2019.11.26.10.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 10:50:45 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2B69C1818C0; Tue, 26 Nov 2019 19:50:44 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libbpf: Fix up generation of bpf_helper_defs.h
In-Reply-To: <20191126183451.GC29071@kernel.org>
References: <20191126151045.GB19483@kernel.org> <20191126154836.GC19483@kernel.org> <87imn6y4n9.fsf@toke.dk> <20191126183451.GC29071@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 26 Nov 2019 19:50:44 +0100
Message-ID: <87d0dexyij.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: _kPl75WCNZWpijKuOfgVWQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> writes:

> Em Tue, Nov 26, 2019 at 05:38:18PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n escreveu:
>> Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> writes:
>>=20
>> > Em Tue, Nov 26, 2019 at 12:10:45PM -0300, Arnaldo Carvalho de Melo esc=
reveu:
>> >> Hi guys,
>> >>=20
>> >>    While merging perf/core with mainline I found the problem below fo=
r
>> >> which I'm adding this patch to my perf/core branch, that soon will go
>> >> Ingo's way, etc. Please let me know if you think this should be handl=
ed
>> >> some other way,
>> >
>> > This is still not enough, fails building in a container where all we
>> > have is the tarball contents, will try to fix later.
>>=20
>> Wouldn't the right thing to do not be to just run the script, and then
>> put the generated bpf_helper_defs.h into the tarball?
>
> I would rather continue just running tar and have the build process
> in-tree or outside be the same.

Hmm, right. Well that Python script basically just parses
include/uapi/linux/bpf.h; and it can be given the path of that file with
the --filename argument. So as long as that file is present, it should
be possible to make it work, I guess?

However, isn't the point of the tarball to make a "stand-alone" source
distribution? I'd argue that it makes more sense to just include the
generated header, then: The point of the Python script is specifically
to extract the latest version of the helper definitions from the kernel
source tree. And if you're "freezing" a version into a tarball, doesn't
it make more sense to also freeze the list of BPF helpers?

-Toke

