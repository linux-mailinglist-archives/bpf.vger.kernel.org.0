Return-Path: <bpf+bounces-47792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E04A0017D
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 00:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B1CB3A3768
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 23:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D36F1BC085;
	Thu,  2 Jan 2025 23:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="GjDxJwkr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604A6149E00
	for <bpf@vger.kernel.org>; Thu,  2 Jan 2025 23:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735859399; cv=none; b=tg6kxzIOkv0CKjV6lv1CXsssNJA1PdAj3NDtSlaJ01eiv5yN5AZQ7JDKuWysbTZ8gXX29DqLK+0j5nzCTl5D4M9Y2JEmT2KtGghp1NEalG3JFkfvnowKdz33v79YZeHHzNRDjxhcK4+PzxuvOtoPC3FTSWVr+yr099PStmAQ6hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735859399; c=relaxed/simple;
	bh=QwXGcTIfAkvS3Fk94gdZWZga5aiJG1ozpD8PqRzULvE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LN6RJdyNZpHMxDpgvf5C4WozkIw3W+YWWskGkzkrtA8TFfNsp/UdP8KqSpgIdbYnsg5T3+fl1gPe5G9KBsEL5XfpiZ/xTIJKYUuXdGmeI/8pgn/kKkK6RcTHw54kSXllUUybGPSOnNokltY+MSS8oIf6QHIjYPnIsfDTBRIu0ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=GjDxJwkr; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1735859387; x=1736118587;
	bh=Iu0u3TGFLGOmO4wQz8Z3WGci4lSPvaIEqNt/sfa4ru4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=GjDxJwkruWNYH3RF/vb+XzeIXZLySCEtpTi67YeJQeVh6E8kczkHlJrzutxu91t4j
	 M93HDrCgdL/NKLn21+lms4VjncBswlOAGwrVNzBhd9RP3fpRByoLDNaUyGy/GZ9X/B
	 kaayeexU3NVEewMPECcwDFyAYtnyBG41Ud3gOEt0/6BOQWgnfkNEviJVwI720XVlLv
	 77ykuntiDsyO5AYtyLS1uovz0zxu2wgZBls4p6MYA/LJnidTy6cYpQGA4AF9UGObB+
	 8lG3nGbh364HE2qeABer1ewSn5j8o5XVa9ZgzsWK4QOEV58ka7DCgAdTdlliJAZY6H
	 A4hI09/g70IKw==
Date: Thu, 02 Jan 2025 23:09:41 +0000
To: Arnaldo Carvalho de Melo <acme@kernel.org>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v3 7/8] dwarf_loader: multithreading with a job/worker model
Message-ID: <4-vX-msMWpvfNXsNhfTJhstFrQrBWmeCS_w1Xg4ZNeam4UQw1dlq_G03ZfBh59J3uRbt7dvQhINp6tGdRzGVZMF2HUZleeH9ZYOdBfN5ICM=@pm.me>
In-Reply-To: <Z3LoTvt7PtUAbh5K@x1>
References: <20241221012245.243845-1-ihor.solodrai@pm.me> <20241221012245.243845-8-ihor.solodrai@pm.me> <Z3LFREHG-8QhoAcc@x1> <Z3LGOXGgK1Qx1zW-@x1> <Z3LoTvt7PtUAbh5K@x1>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 91125609b65179da7dd5be6159109f9b4c244d77
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, December 30th, 2024 at 10:37 AM, Arnaldo Carvalho de Melo <acme@=
kernel.org> wrote:

>=20
>=20
> On Mon, Dec 30, 2024 at 01:11:41PM -0300, Arnaldo Carvalho de Melo wrote:
>=20
> > > Not really :-\
> > >=20
> > > root@number:/home/acme/git/pahole# pfunct --decl_info -F dwarf evtchn=
_fifo_is_pending /lib/modules/6.13.0-rc2/build/vmlinux
> > > /* Used at: /home/acme/git/linux/drivers/xen/events/events_fifo.c /
> > > / <946502e> /home/acme/git/linux/drivers/xen/events/events_fifo.c:206=
 /
> > > bool evtchn_fifo_is_pending(evtchn_port_t port);
> > > / Used at: /home/acme/git/linux/drivers/xen/events/events_fifo.c /
> > > / <946502e> /home/acme/git/linux/drivers/xen/events/events_fifo.c:206=
 */
> > > bool evtchn_fifo_is_pending(evtchn_port_t port);
> > > root@number:/home/acme/git/pahole#
> > >=20
> > > So far I couldn't find an explanation for this oddity... Lets see if
> > > after applying all patches we get past this.
>=20
> > Its not related to this patch series, before we get two outputs for
> > these (and other functions in
> > /home/acme/git/linux/drivers/xen/events/events_fifo.c).
> >=20
> > Still investigating.
>=20
>=20
> root@number:/home/acme/git/pahole# perf probe -x ~/bin/pfunct function__s=
how
> Added new event:
> probe_pfunct:function_show (on function__show in /home/acme/git/pahole/bu=
ild/pfunct)
>=20
> You can now use it in all perf tools, such as:
>=20
> perf record -e probe_pfunct:function_show -aR sleep 1
>=20
> root@number:/home/acme/git/pahole# perf trace -e probe_pfunct:function_sh=
ow --call-graph dwarf pfunct --decl_info -F dwarf evtchn_fifo_set_pending /=
lib/modules/6.13.0-rc2/build/vmlinux
> /* Used at: /home/acme/git/linux/drivers/xen/events/events_fifo.c /
> / <946517a> /home/acme/git/linux/drivers/xen/events/events_fifo.c:200 */
>=20
> void evtchn_fifo_set_pending(evtchn_port_t port);
> /* Used at: /home/acme/git/linux/drivers/xen/events/events_fifo.c /
> / <946517a> /home/acme/git/linux/drivers/xen/events/events_fifo.c:200 */
>=20
> void evtchn_fifo_set_pending(evtchn_port_t port);
> 0.000 pfunct/2006089 probe_pfunct:function_show(__probe_ip: 4208235)
> function__show (/home/acme/git/pahole/build/pfunct)
> pfunct_stealer (/home/acme/git/pahole/build/pfunct)
> cus__steal_now (/home/acme/git/pahole/build/libdwarves.so.1.0.0)
> dwarf_loader__worker_thread (/home/acme/git/pahole/build/libdwarves.so.1.=
0.0)
> start_thread (/usr/lib64/libc.so.6)
> clone3 (/usr/lib64/libc.so.6)
> 0.134 pfunct/2006088 probe_pfunct:function_show(__probe_ip: 4208235)
> function__show (/home/acme/git/pahole/build/pfunct)
> cu_function_iterator (/home/acme/git/pahole/build/pfunct)
> cus__for_each_cu (/home/acme/git/pahole/build/libdwarves.so.1.0.0)
> main (/home/acme/git/pahole/build/pfunct)
> __libc_start_call_main (/usr/lib64/libc.so.6)
> __libc_start_main@@GLIBC_2.34 (/usr/lib64/libc.so.6)
> _start (/home/acme/git/pahole/build/pfunct)
> root@number:/home/acme/git/pahole#
>=20
> With the following patch we get just one output for this case, but that
> isn't the right solution... I'll look on removing the
> cu_function_iterator() based printing, otherwise when printing all
> matches we'll still duplicate the printings.
>=20
> Anyway, doesn't seem related to the problem that tests/tests was
> catching, that I'm not being able to reproduce anymore after having the
> whole series applied, probably some race?

Hi Arnaldo, thank you for testing.

I couldn't reproduce the mismatch error that you saw:

    root@number:/home/acme/git/pahole# tests/tests
      1: Validation of BTF encoding of functions; this may take some time: =
grep: /tmp/btf_functions.sh.OgxoO4/dwarf.funcs: binary file matches
    ERROR: mismatch : BTF 'bool evtchn_fifo_is_pending(evtchn_port_t);' not=
 found; DWARF ''
    Test data is in /tmp/btf_functions.sh.OgxoO4

I've tried a couple of kernels:
  * 6.12 with selftests/bpf config
  * Fedora 6.12.6-100.fc40.x86_64 (my workstation)
  * 6.13-rc2 with Fedora-like config

I saw warnings that don't seem to be related to this series:

    theihor@qube:~/dev/dwarves$ PATH=3D$(realpath build):$PATH vmlinux=3D~/=
git/kernel.org/linux-for-pahole/vmlinux ./tests/tests
      1: Validation of BTF encoding of functions; this may take some time: =
Ok
      2: Default BTF on a system without BTF: Ok
      3: Flexible arrays accounting: WARNING: still unsuported BTF_KIND_DEC=
L_TAG(bpf_fastcall) for bpf_cast_to_kern_ctx already with attribute (bpf_kf=
unc), ignoring
    WARNING: still unsuported BTF_KIND_DECL_TAG(bpf_fastcall) for bpf_rdonl=
y_cast already with attribute (bpf_kfunc), ignoring
    Ok
      4: Pretty printing of files using DWARF type information: Ok
      5: Parallel reproducible DWARF Loading/Serial BTF encoding: Ok

As for potential race, since btf_encoder is sequential and a unit of
work is a CU, I don't see how a single function could have been
missed. Other declarations in events_fifo.c would've been affected I
think.

If you see this again, please let me know.

>=20
> - Arnaldo
>=20
> diff --git a/pfunct.c b/pfunct.c
> index 55eafe8a8e790dcb..9645b004381a7e1e 100644
> --- a/pfunct.c
> +++ b/pfunct.c
> @@ -518,7 +518,13 @@ static enum load_steal_kind pfunct_stealer(struct cu=
 *cu,
>=20
> if (tag) {
> function__show(tag__function(tag), cu);
> - return show_all_matches ? LSK__DELETE : LSK__STOP_LOADING;
> + if (!show_all_matches) {
> + // Expedite exit, since we already did what was requested:
> + // print the first occurrence of a given function
> + exit(0);
> + }
> +
> + return LSK__DELETE;
> }
> } else if (class_name) {
> cu_class_iterator(cu, class_name);



