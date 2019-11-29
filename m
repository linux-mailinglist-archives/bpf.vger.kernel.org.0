Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6099810D264
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2019 09:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfK2IZC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Nov 2019 03:25:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52682 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726143AbfK2IZB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Nov 2019 03:25:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575015900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dvXfLX+3YfaDzm1HU0+ZJqo+B1rhtfnbOz00s1KXV1o=;
        b=Pz11IWA8XkyEwfQp6GtCcNBW4SQ+4RR8f4zNhyyuew7nHLOzp9iBzuz+USPTv8AmHePCrf
        RAXMGnTAYBXDmWxlL9x0qRn9yrWOayf0Z/OTjtGdv0pdHI9aAfXStNmSGm/wjXE3qspr//
        jdJRC2B33WjQzKBzJDkf8aKqMVrWT1I=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-Ok4MFk_-NbaKhIuLu1XbsQ-1; Fri, 29 Nov 2019 03:24:57 -0500
Received: by mail-lf1-f70.google.com with SMTP id 9so1468249lft.17
        for <bpf@vger.kernel.org>; Fri, 29 Nov 2019 00:24:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=NwdD649wYa06LDGBuYg0DJ+wk3uRgAP3a4OQ+w3b49w=;
        b=S2q/JrR1XOBT3mkFS+6ta4f0jtjP2sERqJvuY2lb+GRbur/7fjeZAgKkedzZrbu5jC
         zuoCjU1gRPUxnlb9fZIfhMILJt7HrV30JduSTq7z29BImSWsOaQJs/pI76hcKLzRr+RA
         HTzuLi2VZWnt/qTiJLb2ED1ifbJcNb14GLB2Dt5fhsgcg3M7cacZdTKKtvIPZS0oSKco
         s3Vj6cR1XAcuWpao76s7gqk2nhQBYh5sllCMXhAxnJFx8hCqKrTTGfb9HRV7z5qnd9Di
         avqzWE20h5GfVOmxOJTbeDk939TZilpV4UOoAVno5+mMnCFhD0O79UUxmLSuUCkKpdr0
         4USQ==
X-Gm-Message-State: APjAAAXZn7J/nlbrljN5+asaptrRC6LGCr/1MFRqy17kd2HItGRClvTa
        fOt1B4IIRUIxbDUZcFrkF+EA+bggkLzcl0cn9ALt5w38MMDAJxSc5t+Qlab7G+Vid0GWE0WnLA9
        XW4yTCUGPTr0b
X-Received: by 2002:a05:651c:1066:: with SMTP id y6mr37587981ljm.96.1575015896259;
        Fri, 29 Nov 2019 00:24:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqzwma2V8Jj7dmJeTFQjNtfe9nb4lzAVxmqseq3Dk5KXkNphde5I1fVA0wzjp/tU6YVbsQkmsA==
X-Received: by 2002:a05:651c:1066:: with SMTP id y6mr37587957ljm.96.1575015895795;
        Fri, 29 Nov 2019 00:24:55 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id k22sm9701193lfm.48.2019.11.29.00.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 00:24:54 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2A94E1818BD; Fri, 29 Nov 2019 09:24:53 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH bpf v3] bpftool: Allow to link libbpf dynamically
In-Reply-To: <20191129081251.GA14169@krava>
References: <20191128145316.1044912-1-toke@redhat.com> <20191128160712.1048793-1-toke@redhat.com> <20191129081251.GA14169@krava>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 29 Nov 2019 09:24:53 +0100
Message-ID: <87v9r3um22.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: Ok4MFk_-NbaKhIuLu1XbsQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jiri Olsa <jolsa@redhat.com> writes:

> On Thu, Nov 28, 2019 at 05:07:12PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>
> SNIP
>
>>  ifeq ($(srctree),)
>>  srctree :=3D $(patsubst %/,%,$(dir $(CURDIR)))
>> @@ -63,6 +72,19 @@ RM ?=3D rm -f
>>  FEATURE_USER =3D .bpftool
>>  FEATURE_TESTS =3D libbfd disassembler-four-args reallocarray zlib
>>  FEATURE_DISPLAY =3D libbfd disassembler-four-args zlib
>> +ifdef LIBBPF_DYNAMIC
>> +  FEATURE_TESTS   +=3D libbpf
>> +  FEATURE_DISPLAY +=3D libbpf
>> +
>> +  # for linking with debug library run:
>> +  # make LIBBPF_DYNAMIC=3D1 LIBBPF_DIR=3D/opt/libbpf
>> +  ifdef LIBBPF_DIR
>> +    LIBBPF_CFLAGS  :=3D -I$(LIBBPF_DIR)/include
>> +    LIBBPF_LDFLAGS :=3D -L$(LIBBPF_DIR)/$(libdir_relative)
>> +    FEATURE_CHECK_CFLAGS-libbpf  :=3D $(LIBBPF_CFLAGS)
>> +    FEATURE_CHECK_LDFLAGS-libbpf :=3D $(LIBBPF_LDFLAGS)
>> +  endif
>> +endif
>> =20
>>  check_feat :=3D 1
>>  NON_CHECK_FEAT_TARGETS :=3D clean uninstall doc doc-clean doc-install d=
oc-uninstall
>> @@ -88,6 +110,18 @@ ifeq ($(feature-reallocarray), 0)
>>  CFLAGS +=3D -DCOMPAT_NEED_REALLOCARRAY
>>  endif
>> =20
>> +ifdef LIBBPF_DYNAMIC
>> +  ifeq ($(feature-libbpf), 1)
>> +    # bpftool uses non-exported functions from libbpf, so just add the =
dynamic
>> +    # version of libbpf and let the linker figure it out
>> +    LIBS    :=3D -lbpf $(LIBS)
>
> nice, so linker will pick up the missing symbols and we
> don't need to check on particular libbpf version then

Yup, exactly. I verified with objdump that the end result is a
dynamically linked bpftool with LIBBPF_DYNAMIC is set, and a statically
linked one if it isn't; so the linker seems to be smart enough to just
figure out how to do the right thing :)

-Toke

