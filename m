Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2586B4840F5
	for <lists+bpf@lfdr.de>; Tue,  4 Jan 2022 12:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbiADLfy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Jan 2022 06:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbiADLfx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Jan 2022 06:35:53 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA1FC061761
        for <bpf@vger.kernel.org>; Tue,  4 Jan 2022 03:35:53 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id h5so12411910vkp.5
        for <bpf@vger.kernel.org>; Tue, 04 Jan 2022 03:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=qehx1wdv/VZPOp6oHLVzK1sS3dmrB24QS4m1J3AlPH4=;
        b=MuHZeDUnB65Sy6TMSL1EximSXEGzHlJzsD+rWw3J9zUdeSdibVFSqMqSUTXY6R7608
         dkK/fd7Qf3X/hEDSC4OHYMqs0inseOrIUzLnBlCow5FS2aZwZ/YrM6AxFq/zkOpjBcG+
         Q/VNFcE7zU5pDEOQM36jKxdkHlIkq0M1+BKf9v1/lAkzF0a1nVG8OnWILNShUIEm65Y0
         adfRhyzE/UrQZKfz5tiII9WeM27WEdOKA5B2x7aRGpo1TAmN5ulQ+1B0kPHh4CzGBrar
         YjZgciSSAIx9t/i8qrFpjqr10WPzcHWof2WJioK5NmGI59P35cXDp+v9tYzh3Btd4cMN
         k3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=qehx1wdv/VZPOp6oHLVzK1sS3dmrB24QS4m1J3AlPH4=;
        b=ALsd1y5S1OGKckDAJa6OgWitndykeE13KWKD7InF8RBDOwEY3xjjJYJkC2DlqqbYbe
         tPUvJBWyDgD9HN5XMvVrxnwjOqSe2elW1OS/kTL4LcuRfFwdWIpfV9Vep7WxtGGeheMH
         Yjs6Ren1trj79keu2vuRx8YZUdmIajPsOmuWwiv+6iUgqe1ruywzT9XHpZ6jDbpdo0dT
         SbFddbIPJ31SESesv/FpvLwHzPbWZMUalh+TKftTZbj6pfeh/1rmqMR2INH/kHT3bD1t
         /gIpqOSMEuXeWypEajRQo8aYsQtD+qSRG7pseoKNdH+kNVHxbX7uFDiUVzpUmN4gWd8a
         tC6A==
X-Gm-Message-State: AOAM530WzYoR0eSE8A99Nk1TNR9M78wFjUrXB9UXdz2KKPne5SvVLArp
        lpehjZjWelf20ITPVPIQlCMJTyw36eaLW+b2IEPJZH2NOA==
X-Google-Smtp-Source: ABdhPJwYScZMGSyE2xLtyB5KcqHdRFuwMM+GhN4DAaqBNWT5gGYBl80/8b7yfr932QGIj2JCRrF2iY8Uohq39Hiib8A=
X-Received: by 2002:ac5:cfc4:: with SMTP id m4mr15709529vkf.30.1641296152352;
 Tue, 04 Jan 2022 03:35:52 -0800 (PST)
MIME-Version: 1.0
From:   Tal Lossos <tallossos@gmail.com>
Date:   Tue, 4 Jan 2022 13:35:41 +0200
Message-ID: <CAO15rPnCtpSgH_Nucb=Zkp04iMS1w8uYiFGgbP4LG1rujmd9HA@mail.gmail.com>
Subject: Verification error on bpf_map_lookup_elem with BPF_CORE_READ
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello!
I=E2=80=99ve encountered a weird behaviour of verification error regarding
using bpf_map_lookup_elem (specifically bpf_inode_storage_get in my
use case) and BPF_CORE_READ as a key.
For example, if I=E2=80=99m using an inode_storage map, and let=E2=80=99s s=
ay that I=E2=80=99m
using a hook that has a dentry named =E2=80=9Cdentry=E2=80=9D in the contex=
t, If I
will try to use bpf_inode_storage_get, the only way I could do it is
by passing dentry->d_inode as the key arg, and if I will try to do it
in the CO-RE way by using BPF_CORE_READ(dentry, d_inode) as the key I
will fail (because the key is a =E2=80=9Cinv=E2=80=9D (scalar) and not =E2=
=80=9Cptr_=E2=80=9D -
https://elixir.bootlin.com/linux/v5.11/source/kernel/bpf/bpf_inode_storage.=
c#L266):
struct
{
    __uint(type, BPF_MAP_TYPE_INODE_STORAGE);
    __uint(map_flags, BPF_F_NO_PREALLOC);
    __type(key, int);
    __type(value, value_t);
} inode_storage_map SEC(".maps");

SEC("lsm/inode_rename")
int BPF_PROG(inode_rename, struct inode *old_dir, struct dentry *old_dentry=
,
     struct inode *new_dir, struct dentry *new_dentry,
     unsigned int flags)
{
struct value_t *storage;

storage =3D bpf_inode_storage_get(&inode_storage_map,
old_dentry->d_inode, 0, 0); // this will work
  storage =3D bpf_inode_storage_get(&inode_storage_map,
BPF_CORE_READ(old_dentry, d_inode), 0, 0); // this won't work
    ...
}
From a quick glimpse into the verifier sources I can assume that the
BPF_CORE_READ macro (which calls bpf_core_read), returns a =E2=80=9Cscalar=
=E2=80=9D
(is it because ebpf helpers counts as =E2=80=9Cglobal functions=E2=80=9D?) =
thus
failing the verification.
This behaviour is kind of weird because I would expect to be allowed
to call bpf_inode_storage_get with the BPF_CORE_READ (=E2=80=99s output) as
the key arg.
May I have some clarification on this please?

Thanks.
