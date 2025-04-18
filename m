Return-Path: <bpf+bounces-56255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184CBA93E0C
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 20:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30E2B465014
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 18:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8421022D784;
	Fri, 18 Apr 2025 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iH5lQAAc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D61C202996
	for <bpf@vger.kernel.org>; Fri, 18 Apr 2025 18:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745002707; cv=none; b=HXkaQtGev7BzxQQwZfpa9Lfg4rdA74xPRuyyszlJ+aZyHLDt6Cix+KkxKN6nYVwMc88S6TJSwyOYZQZ1Rdlx4zQWRvA48xC9UF5w2Hv/MnoSSxdDyoBoR7um8exe56aI/taBHjq7eSfNwwLeM2hxGkTFLsBmTUepoVFDSs6T6KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745002707; c=relaxed/simple;
	bh=/LvodyFf5SPJ2lKzkj4fk6x5aIP9RFoFOvdbWPjNGFo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TyhlStjHC1U97vTqhiMM8OITY6xXVgoxdNzcCAW7kemG/AuLM70B594CvUDWs442p7bKaScB3s2Q7eSn4MIWWPtg/fqA1oOubBEGUeM75cadwWi6Brpu7ZqyNHttSXq5f6e4zrVWBjwFP+WFTAnjqdBHx+tnQapLyq1pMDDBlPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iH5lQAAc; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54b10956398so2540930e87.0
        for <bpf@vger.kernel.org>; Fri, 18 Apr 2025 11:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745002703; x=1745607503; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9AHqo+GNG5biSzSLo30n3QX7hA5O6EoVDrnBwDO7bmM=;
        b=iH5lQAAcS6pwyfiWQTM/T4LmXr5IZzMqWFfADomc05HS2GM5AX9boPyTHARH93HA2x
         Pa/vqshiN8UajXHnY+po+miXqAh+mJFoW3N/XS/+hWuQP0fzliB065ZljwZrD/1ekGnK
         IuWU/DpFMoOkg8X6G81gprkWAsU0UxH1wfGE3KfC+hSkn6dJZ8lrr+mRgzbecB3GzLAU
         w4xbuSNKvLDJ3p2iO8vYWhpToI60wNRyF65RgqTB8oKifjjeNzIB7NhcgS8//CxC214+
         xOsrZ6qbaNG6aTqzNg7RASpLLlH9PBMMw3LL/BbSc+d6jknnlFlbhbTl1B0dneh1cc1V
         /6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745002703; x=1745607503;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9AHqo+GNG5biSzSLo30n3QX7hA5O6EoVDrnBwDO7bmM=;
        b=iseE5ToWyXM2B5o2fsCOta0RbM1AEHcbERY+OrzS7/Zla96c3zSRrhBew6Ino6RmBC
         k7Scek5XzfQygaNMvxWUyA8lCIW/eayPDOBBzl7i0Mu00QVAcVfOHfvFFy8oagxmqLXR
         SVs5nPjUWOhSU2XEiUYyB1alM5BGYpu2KN6fB2LY3vFNwiJsBqwOqbhCD8OjANJhpF+L
         qFz6fCZKcdGBD7HHZeJYGLJuqs0V0Qj40NVwB8RtBDwv1FyqInUfAkLO5HYENDP5+GZu
         BVzVTo1jzDlm4mkaAcGXI654RCv039jnkl769BhboG4T4ysmUy4sZKYY9yPi3M180V6U
         mliA==
X-Forwarded-Encrypted: i=1; AJvYcCXfSR5RP0SHOfGrqctVZLv8r0UQJVrYOFzsx+TOqsoV+C2/3Fgel2+cQQMImX7tzIAt2QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcFFJGsQ+xOMFP6cFo16CsKiv3IymFlh7LCr2/z9V0jyokqLyn
	OgRfGkhqRkPuU6vUyPQ+z+BaIV9P8qk/ppS7GYnqvITsXQfwBdMmyDv7+a9BDT7HgVmW0fIsiRq
	2gSbNzDfqAqX1QJ/RFlo3jQF8rc4=
X-Gm-Gg: ASbGncuyuys63DV5UDrKgeqyITwrYG+homuEihYL0OkfScgU8A/qETYGzZhlIpZRnmV
	o2YdPbxZC2ZVVTkoIETKOqCc73WHaMokv5plaIJGDCTBC49N4GKWN660hKxGbO82i64czH9jSfb
	jJGdEqs+fi8uWiOLJ4YRli4RcVCOyBI9gxpr1LALeyxWmM17eubZxC
X-Google-Smtp-Source: AGHT+IGIcLHryMDikYwrb0XuUZfOBiSYsg76D/5T1dDTFbPsP6+mJOXM5zNsc2D3LwdLvDReMqQASbAsls+Zieuqr9k=
X-Received: by 2002:a05:6512:3b1e:b0:549:744c:fffb with SMTP id
 2adb3069b0e04-54d6e7f214emr1106325e87.23.1745002703008; Fri, 18 Apr 2025
 11:58:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Fri, 18 Apr 2025 20:57:46 +0200
X-Gm-Features: ATxdqUFz_eTH_aOdZbFNspTGk93BHSVnIyUlKCRn0qfHwOdN2K4WjvStze8TxXg
Message-ID: <CA+icZUW31vpS=R3zM6G4FMkzuiQovqtd+e-8ihwsK_A-QtSSYg@mail.gmail.com>
Subject: pahole v1.30 and libbpf: Introduce kflag for type_tags and decl_tags
 in BTF
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alan Maguire <alan.maguire@oracle.com>, 
	Jiri Olsa <jolsa@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org, sudipm.mukherjee@gmail.com, 
	cavok@debian.org
Content-Type: text/plain; charset="UTF-8"

[ QUESTION ]

How to check if libbpf API functions
 * btf__add_decl_attr()
 * btf__add_type_attr()
work as expected with pahole v1.30?

Looks like I need Linux version >= v6.15-rc1?

dileks@iniza:~/src/linux/git$ git log --oneline -1
51d1b1d42841c557dabde5b140ae20774591e6dc
51d1b1d42841 libbpf: Introduce kflag for type_tags and decl_tags in BTF

Add the following functions to libbpf API:
 * btf__add_type_attr()
 * btf__add_decl_attr()

dileks@iniza:~/src/linux/git$ git describe --contains
51d1b1d42841c557dabde5b140ae20774591e6dc
v6.15-rc1~98^2~87^2~5

Currently, I use Debian-kernel v6.12.22 and want to build a selfmade
v6.12.24 (when it is released).

If you need further information, please let me know.

Best Thanks,
-Sedat-

P.S.: My investigations

[ DEBIAN PAHOLE ]

Debian/unstable AMD64 ships on my request pahole version 1.30-1.
This version was built against libbpf-dev version (1:1.5.0-2)

Link: https://packages.debian.org/sid/pahole
Link: https://packages.debian.org/sid/libbpf-dev
Link: https://bugs.debian.org/1103000


[ SELFMADE PAHOLE ]

Prereq: libbpf API version >= 1.6.0

dileks@iniza:~/src/pahole/git$ git describe
v1.29-16-gb45268b74da1

dileks@iniza:~/src/pahole/git$ git log --oneline -1
b45268b74da1 (HEAD -> pahole-v1.30, tag: v1.30, origin/next,
origin/master, origin/HEAD, master) Prep 1.30

root# /opt/pahole/bin/pahole --version
v1.30

INFO: git describe should report v1.30


[ BUILD INSTRUCTIONS ]

VER="1.30"
PREFIX="/opt/pahole-$VER"
PREFIX_CMAKE_OPTS="-DCMAKE_INSTALL_PREFIX=$PREFIX"

echo $PREFIX_CMAKE_OPTS

cd ..
mkdir build
cd build

# NOTE: See upstream commit "CMakeList.txt: Respect CMAKE_INSTALL_LIBDIR"
##cmake $PREFIX_CMAKE_OPTS -D__LIB=lib ../git
LC_ALL=C.UTF-8 cmake $PREFIX_CMAKE_OPTS ../git
make
sudo make install

NOTE: Do NOT forget to run `ldconfig` as root (see below).


[ LDCONFIG ]

File: /etc/ld.so.conf.d/a-local-pahole.conf

# pahole lib configuration
/opt/pahole/lib

root# cd /opt
root# ln -sf pahole-$VER pahole
root# ldconfig
root# ldconfig --print-cache | grep pahole


[ PAHOLE - CMAKE LOG (LIBBPF) ]

[...]
-- Submodule update
Submodule 'lib/bpf' (https://github.com/libbpf/libbpf) registered for
path 'lib/bpf'
Cloning into '/home/dileks/src/pahole/git/lib/bpf'...
Submodule path 'lib/bpf': checked out '42a6ef63161a8dc4288172b27f3870e50b3606f7'
-- Submodule update - done

Link: https://web.git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=v1.30&id=fe2dcd28ba9d348744ee93fed43cbed5dc0d6a43


[ BTF FEATURES ]

root# /opt/pahole/bin/pahole --usage | grep feature
           [--btf_encode_force] [--btf_features=FEATURE_LIST]
           [--btf_features_strict=FEATURE_LIST_STRICT] [--btf_gen_all]
           [--skip_missing] [--sort] [--structs] [--supported_btf_features]

NOTE: --btf_feature*s* (all options plural) VS. commit 40e82f5be9a7
("pahole: Introduce --btf_feature=attributes")

root# /opt/pahole/bin/pahole --supported_btf_features
encode_force,var,float,decl_tag,type_tag,enum64,optimized_func,consistent_func,decl_tag_kfuncs,reproducible_build,distilled_base,global_var,attributes

NOTE: Supported = attributes


[ LIBBPF API VERSION >= 1.6.0 ]

Link: https://web.git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=v1.30&id=fe2dcd28ba9d348744ee93fed43cbed5dc0d6a43

commit fe2dcd28ba9d348744ee93fed43cbed5dc0d6a43 ("pahole: Sync with
libbpf mainline")

Pull recently added libbpf API functions:
 * btf__add_decl_attr()
 * btf__add_type_attr()

root# llvm-dwarfdump-19 /opt/pahole/bin/pahole | grep btf | grep add
               DW_AT_name      ("btf__add_type_attr")
               DW_AT_name      ("btf__add_enum64")


[ pahole.git - lib/bpf/src/libbpf.map ]

LIBBPF_1.6.0 {
       global:
               bpf_linker__add_buf;
               bpf_linker__add_fd;
               bpf_linker__new_fd;
               btf__add_decl_attr;
               btf__add_type_attr;
} LIBBPF_1.5.0;

-EOT-

