Return-Path: <bpf+bounces-1118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D465D70E415
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 19:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B98D281395
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 17:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38B421CCF;
	Tue, 23 May 2023 17:58:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0512098A
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 17:58:29 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CFC8E
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 10:58:27 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 36662C1595FE
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 10:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1684864707; bh=b1mp2+gddD9eewGveqd2zy8qX86xXGB05xuowz6y7dw=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=F5UMlg6+6n/WjLDc6uvR86F1MosVCpzZtMsh24aOnwuNpGNBNFOZejfF9F8PHBoiE
	 CUqB2RRk9vJMFOGWdlJh7TKE5VgechIa76ahTUAOzSanO3d5FT9Usr1HUrjiD/UPPG
	 4OPwbKxBXsdyoXk2VpiWbkSRLoii65+tJBfchx/c=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue May 23 10:58:27 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id E07B1C1524AE;
	Tue, 23 May 2023 10:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1684864706; bh=b1mp2+gddD9eewGveqd2zy8qX86xXGB05xuowz6y7dw=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=AL6WXTZ2Gk90A1WkdURjD2gSuc0gd4LOzoBZIhpUhFuIe5TJD+p7C+HdG8wQayPfZ
	 9rbqhsDwUA8ojEKgGW0SwUkxXHtLAYptwzQlXwVcmweajKIPusJlYt2sjMqS3IASSl
	 58aLuMmpeqAMR0BePQjqUfATMJ86leavztklBOeY=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id E327BC1522DB
 for <bpf@ietfa.amsl.com>; Tue, 23 May 2023 10:58:24 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -2.096
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=sandelman.ca
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d78k1nlKCTd2 for <bpf@ietfa.amsl.com>;
 Tue, 23 May 2023 10:58:20 -0700 (PDT)
Received: from tuna.sandelman.ca (tuna.sandelman.ca
 [IPv6:2607:f0b0:f:3:216:3eff:fe7c:d1f3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id C889AC1522D9
 for <bpf@ietf.org>; Tue, 23 May 2023 10:58:20 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
 by tuna.sandelman.ca (Postfix) with ESMTP id 989693898E;
 Tue, 23 May 2023 13:58:19 -0400 (EDT)
Received: from tuna.sandelman.ca ([127.0.0.1])
 by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id yX8AN5P0-Xpv; Tue, 23 May 2023 13:58:18 -0400 (EDT)
Received: from sandelman.ca (obiwan.sandelman.ca [209.87.249.21])
 by tuna.sandelman.ca (Postfix) with ESMTP id D2C153898D;
 Tue, 23 May 2023 13:58:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandelman.ca;
 s=mail; t=1684864698;
 bh=xIUP/tp9QG9cpn3YJQ3VmVj0Bmk6WEqbTBvawtZOaak=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=AAYcnCNXlxmPn+eoiuWPzaac0JmY7xxbFrfmTk5Ez0MxvSO+uCALry+eU1bKwkqqB
 wsGszBewzcv1TZ86rrKMZIesolRXNGqZKPgVcpFO1ZgZP2HRu9OV+3Hh4TGsudsMQF
 9gg+HBgAHtegXLVB4PKGVfexdKvbXh0n662/Q6ry0ppBw3GI8I8wt8KmiPxdn0oadA
 t7VYu1NGFCd+eExCkrtsmO3xbcekeG3ICO6Em/JBFGv/NphIe7JuS04hjY+IdlfhEj
 hVcT8KfuVOchhDUjT9OZE/Ha7xlKa2sxIjBN5rq0WZLJL61DLtqCZLHgvYPqZ8PVmE
 1na8YXCzURIww==
Received: from localhost (localhost [IPv6:::1])
 by sandelman.ca (Postfix) with ESMTP id B2FFB238;
 Tue, 23 May 2023 13:58:18 -0400 (EDT)
From: Michael Richardson <mcr+ietf@sandelman.ca>
To: "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
In-Reply-To: <20230523163200.GD20100@maniforge>
References: <PH7PR21MB38780769D482CC5F83768D3CA37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87v8grkn67.fsf@gnu.org>
 <PH7PR21MB3878BCFA99C1585203982670A37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87r0rdy26o.fsf@gnu.org>
 <PH7PR21MB3878B869D69FD35FA718AF5DA37FA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230523163200.GD20100@maniforge>
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; GNU Emacs 27.1
X-Face: $\n1pF)h^`}$H>Hk{L"x@)JS7<%Az}5RyS@k9X%29-lHB$Ti.V>2bi.~ehC0;
 <'$9xN5Ub#
 z!G,p`nR&p7Fz@^UXIn156S8.~^@MJ*mMsD7=QFeq%AL4m<nPbLgmtKK-5dC@#:k
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 May 2023 13:58:18 -0400
Message-ID: <18272.1684864698@localhost>
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/BS8ORqmoJSzOpWD78uCajy9A2N4>
Subject: Re: [Bpf] IETF BPF working group draft charter
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2074491533481227445=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--===============2074491533481227445==
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


David Vernet <void@manifault.com> wrote:
    > As far as I know (please correct me if I'm wrong), there isn't really=
 a
    > precedence for standardizing ABIs like this. For example, x86 calling

All of the eBPF work seems unprecedented.
I don't see having this in the charter is a problem.

We may fail to get consensus on it, and not make a milestone, but I don't s=
ee
a reason not to be allowed to talk about this.
(and maybe in the end, it's a no-op)

=2D-
Michael Richardson <mcr+IETF@sandelman.ca>   . o O ( IPv6 I=C3=B8T consulti=
ng )
           Sandelman Software Works Inc, Ottawa and Worldwide





--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFKBAEBCgA0FiEEbsyLEzg/qUTA43uogItw+93Q3WUFAmRs/roWHG1jcitpZXRm
QHNhbmRlbG1hbi5jYQAKCRCAi3D73dDdZVonB/9DgkeUGk+Mib+b63sq+ojq2ESJ
zhu8ir5FsLPkjL2FIOPHGee79h8B5BsYIVGaSUCmZCu6TQjpg2HqhI+tDVkqFLO7
5aO4z4xrT4XXaFgm4EM666PoBIZJyNYLDdLE20BknQIDC5iWAId6phUzaAzfnn80
SllYkrFm54vocBW8mqPBD79VoBJIjeu2PLCL+5H+w0720/cQRJPOshcisp+/v2zv
Z3mTHx/6VHEnv2rQhk6lz8qsojG5Uv2dMkQ+MVb2UOAJ/wK3clheNZOfkgRxV+kn
WOdYQ7z8LcXGZTf4oP2Q6ZSEr9RINPNQFcoPKhoxccx/K6rSJJXcEQxdbIyF
=drce
-----END PGP SIGNATURE-----
--=-=-=--


--===============2074491533481227445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============2074491533481227445==--


