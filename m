Return-Path: <bpf+bounces-4861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28563750D93
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 18:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6FE2281A47
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 16:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551F5214FB;
	Wed, 12 Jul 2023 16:08:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223E8214EC
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 16:08:41 +0000 (UTC)
Received: from smtp-out.orange.com (smtp-out.orange.com [80.12.210.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5A6134
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 09:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=orange.com; i=@orange.com; q=dns/txt; s=orange002;
  t=1689178120; x=1720714120;
  h=to:subject:date:message-id:mime-version:
   content-transfer-encoding:from;
  bh=k6IDUGTjRY+gFZ2bCmUrfcCbTog48TscU6S/pyszb8A=;
  b=p84ZzSWd0aQqAsvBFJcnsPq6jii9FCcVnYlOTG74+dC3E5JHMBrOJJLv
   A5n43ymgyqI3UuughqxtmlrxYeCnDbb/OO16tXC1+UGyDh6fQzhKJGTTU
   0xUGOx5i4XK64lFKmaH1AcspNvoUJAYeBMVgDDFO79j95GTbcpUu3YgGv
   cAzRZW7Cwm44jiKZXYFc9VZCMrGu1/KAIcILq+dG7W7MzG4xDLNaOUws6
   yfyL0Q4z1WbvXeoOHS+ibBDR/SJAoK/jxpBd2cbbMU4Ezi+DSsUtDGaKE
   HVqMASYx6Ay6jM1HTkNOuUBWNGKpvrH0k/MthB2c6dPQPbB8HGQQlM6av
   g==;
Received: from unknown (HELO opfedv3rlp0g.nor.fr.ftgroup) ([x.x.x.x]) by
 smtp-out.orange.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 18:08:38 +0200
Received: from unknown (HELO OPE16NORMBX204.corporate.adroot.infra.ftgroup)
 ([x.x.x.x]) by opfedv3rlp0g.nor.fr.ftgroup with
 ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jul 2023 18:08:39 +0200
Received: from OPE16NORMBX204.corporate.adroot.infra.ftgroup [x.x.x.x] by
 OPE16NORMBX204.corporate.adroot.infra.ftgroup [x.x.x.x] with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 18:08:38 +0200
Received: from OPE16NORMBX204.corporate.adroot.infra.ftgroup ([x.x.x.x]) by
 OPE16NORMBX204.corporate.adroot.infra.ftgroup ([x.x.x.x]) with mapi id
 15.01.2507.027; Wed, 12 Jul 2023 18:08:38 +0200
From: emile.stephan@orange.com
X-IronPort-AV: E=Sophos;i="6.01,200,1684792800"; 
   d="scan'208";a="14011009"
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: subscribe
Thread-Topic: subscribe
Thread-Index: Adm02xEwKFzeEKndTI+URXA7ro1Dvg==
Date: Wed, 12 Jul 2023 16:08:38 +0000
Message-ID: <df54711a8f35476d91c01ad43bbbdc8b@orange.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_e6c818a6-e1a0-4a6e-a969-20d857c5dc62_Enabled=true;
 MSIP_Label_e6c818a6-e1a0-4a6e-a969-20d857c5dc62_SetDate=2023-07-12T16:08:34Z;
 MSIP_Label_e6c818a6-e1a0-4a6e-a969-20d857c5dc62_Method=Standard;
 MSIP_Label_e6c818a6-e1a0-4a6e-a969-20d857c5dc62_Name=Orange_restricted_internal.2;
 MSIP_Label_e6c818a6-e1a0-4a6e-a969-20d857c5dc62_SiteId=90c7a20a-f34b-40bf-bc48-b9253b6f5d20;
 MSIP_Label_e6c818a6-e1a0-4a6e-a969-20d857c5dc62_ActionId=e8b60bfe-bae5-410e-a65b-b9e0837b2820;
 MSIP_Label_e6c818a6-e1a0-4a6e-a969-20d857c5dc62_ContentBits=2
x-originating-ip: [10.115.26.53]
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi

Can you add me to the ml ?

Regards
Emile

Orange Restricted
___________________________________________________________________________=
_________________________________
Ce message et ses pieces jointes peuvent contenir des informations confiden=
tielles ou privilegiees et ne doivent donc
pas etre diffuses, exploites ou copies sans autorisation. Si vous avez recu=
 ce message par erreur, veuillez le signaler
a l'expediteur et le detruire ainsi que les pieces jointes. Les messages el=
ectroniques etant susceptibles d'alteration,
Orange decline toute responsabilite si ce message a ete altere, deforme ou =
falsifie. Merci.

This message and its attachments may contain confidential or privileged inf=
ormation that may be protected by law;
they should not be distributed, used or copied without authorisation.
If you have received this email in error, please notify the sender and dele=
te this message and its attachments.
As emails may be altered, Orange is not liable for messages that have been =
modified, changed or falsified.
Thank you.


