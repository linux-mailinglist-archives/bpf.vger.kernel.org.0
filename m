Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CECA311E9F
	for <lists+bpf@lfdr.de>; Sat,  6 Feb 2021 17:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhBFQ0L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Feb 2021 11:26:11 -0500
Received: from wildebeest.demon.nl ([212.238.236.112]:47000 "EHLO
        gnu.wildebeest.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhBFQ0K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Feb 2021 11:26:10 -0500
Received: from librem (deer0x15.wildebeest.org [172.31.17.151])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by gnu.wildebeest.org (Postfix) with ESMTPSA id 4216A30278CD;
        Sat,  6 Feb 2021 17:25:28 +0100 (CET)
Received: by librem (Postfix, from userid 1000)
        id BD303C100B; Sat,  6 Feb 2021 17:24:19 +0100 (CET)
Date:   Sat, 6 Feb 2021 17:24:19 +0100
From:   Mark Wieelard <mark@klomp.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     sedat.dilek@gmail.com, Masahiro Yamada <masahiroy@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
        Tom Stellard <tstellar@redhat.com>
Subject: Re: ERROR: INT DW_ATE_unsigned_1 Error emitting BTF type
Message-ID: <20210206162419.GC2851@wildebeest.org>
References: <20210205192446.GH920417@kernel.org>
 <cb743ab8-9a66-a311-ed18-ecabf0947440@fb.com>
 <CA+icZUUcjJASPN8NVgWNp+2h=WO-PT4Su3-yHZpynNHCrHEb-w@mail.gmail.com>
 <d59c2a53-976c-c304-f208-67110bdd728a@fb.com>
 <CA+icZUVhgnJ9j7dnXxLQi3DcmLrqpZgcAo2wmHJ_OxSQyS6DQg@mail.gmail.com>
 <CA+icZUWFx47jWJsV6tyoS5f18joPLyE8TOeeyVgsk65k9sP2WQ@mail.gmail.com>
 <CA+icZUUj1P_PAj=E8iF=C4m6gYm9zqb+WWbOdoTqemTeGnZbww@mail.gmail.com>
 <CA+icZUWY0zkOb36gxMOuT5-m=vC5_e815gkSEyM45sO+jgcCZg@mail.gmail.com>
 <CA+icZUW+4=WUexA3-qwXSdEY2L4DOhF1pQfw9=Bf2invYF1J2Q@mail.gmail.com>
 <8ff11fa8-46cd-5f20-b988-20e65e122507@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ff11fa8-46cd-5f20-b988-20e65e122507@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Flag: NO
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on gnu.wildebeest.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On Sat, Feb 06, 2021 at 12:26:44AM -0800, Yonghong Song wrote:
> With the above vmlinux, the issue appears to be handling
> DW_ATE_signed_1, DW_ATE_unsigned_{1,24,40}.
> 
> The following patch should fix the issue:

That doesn't really make sense to me. Why is the compiler emitting a
DW_TAG_base_type that needs to be interpreted according to the
DW_AT_name attribute?

If the issue is that the size of the base type cannot be expressed in
bytes then the DWARF spec provides the following option:

    If the value of an object of the given type does not fully occupy
    the storage described by a byte size attribute, the base type
    entry may also have a DW_AT_bit_size and a DW_AT_data_bit_offset
    attribute, both of whose values are integer constant values (see
    Section 2.19 on page 55). The bit size attribute describes the
    actual size in bits used to represent values of the given
    type. The data bit offset attribute is the offset in bits from the
    beginning of the containing storage to the beginning of the
    value. Bits that are part of the offset are padding.  If this
    attribute is omitted a default data bit offset of zero is assumed.

Would it be possible to use that encoding of those special types?  If
not, can we try to come up with some extension that doesn't require
consumers to match magic names?

Thanks,

Mark
