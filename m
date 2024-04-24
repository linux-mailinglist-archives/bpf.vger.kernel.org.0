Return-Path: <bpf+bounces-27720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA278B13A3
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 21:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E98101C23088
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 19:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD9382C76;
	Wed, 24 Apr 2024 19:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHJrLjV0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D3A762D0
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 19:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713987459; cv=none; b=oEf1WTxaUtykILKEQofOw3gHei6jPnXlI74WZCJB4Acu3OQwMTVagNu0g/B/nlvIhcbe15vrhG3GgQeLNHIXcWUri3rd25CgLFb9BBO6+6QidYaG7PlyP5NekK/p6VkTF5ygYp/2a1lhpHeJm1Hh02TfPbd4J8u/Rzrjg5aV2jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713987459; c=relaxed/simple;
	bh=Ou9BbuksM/YoNV6OVEziBbgN76Pemw/CvTQGcjm1UOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R4isDZMMI6ZHRb17fzDV92R9gH9/TTIdhHqslflMw63izDJ4jp7RJKypCgP08LYtdwY4FZ4dyQM1zhZAuA9zvb0kUrEpj+78Fk1q/uy+xZ52qhsy3c9ssPCcNJYgy7dkewVK11DHGUd0hlgcjW6Z9IWGa+6LPoEVpR1zI/N3iso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHJrLjV0; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34a32ba1962so110084f8f.2
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 12:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713987456; x=1714592256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apIxbs5eyTlwgFpLAq+dv2rJlg1m79nf3vpNEa+tjoE=;
        b=aHJrLjV0diD9vggZbXmsSYKW6Jn8DAIAMxoT2WYpTgoBqlH2DAk0GxAXuM6+AOF6EF
         42RXms/jjKl6Bi9IGEXLm3sG3tpKctgAaZZrBdMxID5Rzt7fKSxdovpmZ8Isx/9ngE85
         3NxEtqwkFh+BDHF08uzZIGtA1WzUksuAUvpF0/QEmyhxUncy2SXg/0iic05uDgHn0YaY
         KgIch588sKKjUCCL+so5yY5k1PY6EFr/TEJYe8YBh99tSbRe+9a+c9/lOGbgVf30rgNe
         iyIn+3ixlrNZ2Rrd5CYdOIGvnUNMwaRii3qNtgOJdHBGTALTPmrnIamj1yOxNv1XjJfZ
         t6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713987456; x=1714592256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=apIxbs5eyTlwgFpLAq+dv2rJlg1m79nf3vpNEa+tjoE=;
        b=LqeNx4LBtRVP34vAUPCBEZm4tnUDRcjdjb26HmZl9zkVkyxfcP0msqdMJcUnUU5CQx
         4CoIqD8/lWm5V32Q7Do8xrQOyPRIw18yeDeA7Fh8dsXUXaqGXd3dzCmZr/qYT074sAPh
         tZcaN20DS5KusRnJ/xWp6qZKugquG+6KMFqK/cbx6AdLms0fd3lYysJVC5/Te9JA8TQy
         W80gGSYBlmXICvwwHCCkLA2u7f/yIVhpf6GnVQF8vDqNAFO0rHrkizCdMxolNo8uE20A
         SZnfpiw5RpQknXItgrGBc1HHNK2jzIVcgT8+WL36FYvBFs+qHVB7ISdlUpcWCWvpCVmt
         CRRQ==
X-Gm-Message-State: AOJu0YwqQqYSCxcVpJRjANnP5Rl5e2u/zu/bOAhV5dTYx4/7vtgowLm8
	GzWMY+J142bQq1BTnSBBx1LLlwNvCgJXd6ZIedeF5VsfbqjjuLU0OmBfsSijUx0jdJBPZnfOkCm
	UEjmp7TanXMGno0gG6DUdB0xSAdU=
X-Google-Smtp-Source: AGHT+IHjk0tFBGLilCaxhye78O6bMqytLxeKsL1pgUdSfGiknSdBqesGZNQDPT1HAMleDdFjbXYFm+9cvKXCpGR6t9k=
X-Received: by 2002:a5d:634c:0:b0:346:200d:7b42 with SMTP id
 b12-20020a5d634c000000b00346200d7b42mr2571984wrw.25.1713987456319; Wed, 24
 Apr 2024 12:37:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87zftj9cdu.fsf@oracle.com>
In-Reply-To: <87zftj9cdu.fsf@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 24 Apr 2024 12:37:24 -0700
Message-ID: <CAADnVQJqFYP2JraX+41VL=MWbZKFSMSNh=-skcQWY570xB7NFQ@mail.gmail.com>
Subject: Re: process_l3_headers_v6 in test_xdp_noinline.c
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: bpf <bpf@vger.kernel.org>, David Faust <david.faust@oracle.com>, 
	Cupertino Miranda <cupertino.miranda@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 5:25=E2=80=AFAM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>
> Hello.
> The following function in the BPF selftest progs/test_xdp_noinline.c:
>
>   /* don't believe your eyes!
>    * below function has 6 arguments whereas bpf and llvm allow maximum of=
 5
>    * but since it's _static_ llvm can optimize one argument away
>    */
>   __attribute__ ((noinline))
>   static int process_l3_headers_v6(struct packet_description *pckt,
>                                  __u8 *protocol, __u64 off,
>                                  __u16 *pkt_bytes, void *data,
>                                  void *data_end)
>   {
>         struct ipv6hdr *ip6h;
>         __u64 iph_len;
>         int action;
>
>         ip6h =3D data + off;
>         if (ip6h + 1 > data_end)
>                 return XDP_DROP;
>         iph_len =3D sizeof(struct ipv6hdr);
>         *protocol =3D ip6h->nexthdr;
>         pckt->flow.proto =3D *protocol;
>         *pkt_bytes =3D bpf_ntohs(ip6h->payload_len);
>         off +=3D iph_len;
>         if (*protocol =3D=3D 45) {
>                 return XDP_DROP;
>         } else if (*protocol =3D=3D 59) {
>                 action =3D parse_icmpv6(data, data_end, off, pckt);
>                 if (action >=3D 0)
>                         return action;
>         } else {
>                 memcpy(pckt->flow.srcv6, ip6h->saddr.in6_u.u6_addr32, 16)=
;
>                 memcpy(pckt->flow.dstv6, ip6h->daddr.in6_u.u6_addr32, 16)=
;
>         }
>         return -1;
>   }
>
> Relies, as acknowledged in the comment block, on LLVM optimizing out one
> of the arguments.  As it happens GCC doesn't optimize that argument out,
> and as a result it fails at compile-time when building
> tst_xdp_noinline.c.
>
> Would it be possible to rewrite this particular test to not rely on that
> particular optimization?

Feel free to send a patch that reduces it to 5 args.
This test was a copy paste of katran.
There was no intent to test this 6->5 llvm optimization.

