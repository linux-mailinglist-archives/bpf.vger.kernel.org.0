Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B7058BC1F
	for <lists+bpf@lfdr.de>; Sun,  7 Aug 2022 19:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiHGRxS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Aug 2022 13:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbiHGRxS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 7 Aug 2022 13:53:18 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79506172
        for <bpf@vger.kernel.org>; Sun,  7 Aug 2022 10:53:17 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 277AFRhW003582
        for <bpf@vger.kernel.org>; Sun, 7 Aug 2022 10:53:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=JsVNbDdTkmOyADU8ek31XyLW1pIrSxLQSnYJkOIOs2s=;
 b=FYkZLUI8kyymk2khiTW5d6k2JrpKwqMUw+EXssqzxGR440cKI01PnIPxDzu2OrZmMZ4b
 qptw0Sckp1jVR9x9NV5pDbNpwcVmn712KxmCJymSBudkUWwDK3OJLJR4Qpa9AlXLXH/Z
 YsUQVz5WFxGEPUi/m/8ymlBqyEQgxbZypOY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3hskt8ntpw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 07 Aug 2022 10:53:16 -0700
Received: from twshared30313.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 7 Aug 2022 10:53:15 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 833C7DC75B92; Sun,  7 Aug 2022 10:53:09 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH dwarves] dwarf_loader: encode char type as signed
Date:   Sun, 7 Aug 2022 10:53:09 -0700
Message-ID: <20220807175309.4186342-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: LfzuIYes3Evw2T-kKwaFJZTyFvOcKbh0
X-Proofpoint-ORIG-GUID: LfzuIYes3Evw2T-kKwaFJZTyFvOcKbh0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-07_11,2022-08-05_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, the pahole treats 'char' or 'signed char' type
as unsigned in BTF generation. The following is an example,
  $ cat t.c
  signed char a;
  char b;
  $ clang -O2 -g -c t.c
  $ pahole -JV t.o
  ...
  [1] INT signed char size=3D1 nr_bits=3D8 encoding=3D(none)
  [2] INT char size=3D1 nr_bits=3D8 encoding=3D(none)
In the above encoding '(none)' implies unsigned type.

But if the same program is compiled with bpf target,
  $ clang -target bpf -O2 -g -c t.c
  $ bpftool btf dump file t.o
  [1] INT 'signed char' size=3D1 bits_offset=3D0 nr_bits=3D8 encoding=3DS=
IGNED
  [2] VAR 'a' type_id=3D1, linkage=3Dglobal
  [3] INT 'char' size=3D1 bits_offset=3D0 nr_bits=3D8 encoding=3DSIGNED
  [4] VAR 'b' type_id=3D3, linkage=3Dglobal
  [5] DATASEC '.bss' size=3D0 vlen=3D2
          type_id=3D2 offset=3D0 size=3D1 (VAR 'a')
          type_id=3D4 offset=3D0 size=3D1 (VAR 'b')
the 'char' and 'signed char' are encoded as SIGNED integers.

Encode 'char' and 'signed char' as SIGNED should be a right to
do and it will be consistent with bpf implementation.

With this patch,
  $ pahole -JV t.o
  ...
  [1] INT signed char size=3D1 nr_bits=3D8 encoding=3DSIGNED
  [2] INT char size=3D1 nr_bits=3D8 encoding=3DSIGNED

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 dwarf_loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index d892bc3..c2ad2a0 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -560,7 +560,7 @@ static struct base_type *base_type__new(Dwarf_Die *di=
e, struct cu *cu, struct co
 		bt->bit_size =3D attr_numeric(die, DW_AT_byte_size) * 8;
 		uint64_t encoding =3D attr_numeric(die, DW_AT_encoding);
 		bt->is_bool =3D encoding =3D=3D DW_ATE_boolean;
-		bt->is_signed =3D encoding =3D=3D DW_ATE_signed;
+		bt->is_signed =3D (encoding =3D=3D DW_ATE_signed) || (encoding =3D=3D =
DW_ATE_signed_char);
 		bt->is_varargs =3D false;
 		bt->name_has_encoding =3D true;
 		bt->float_type =3D encoding_to_float_type(encoding);
--=20
2.30.2

