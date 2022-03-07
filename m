Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4CB4D0C3B
	for <lists+bpf@lfdr.de>; Tue,  8 Mar 2022 00:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343951AbiCGXtK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Mar 2022 18:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344005AbiCGXtF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Mar 2022 18:49:05 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021016.outbound.protection.outlook.com [52.101.62.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4071B1ADA6
        for <bpf@vger.kernel.org>; Mon,  7 Mar 2022 15:48:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKPTO3U2qMI6FA9JTkvnovZJLTJs2VeeRH2dwt5Xczyuw0IrS/CjoG1VL8rrgrtgsdvHwuXB3uavTRi+fbd70XZgWXxlwcj+Rw09lduxbiJf6fFGzpP9ykcj8K230jk5g0FdmJ49JvS3BMHlQQuK8frqYgChGQ0VKG1e4RyzuyeWzvZm856zpQsa8zt6KcxCKvDGyGitH9VeneeCUYfWVLJhRCEoImdlDnDWkYVHcKMkZqarxUE5J5iUGngB0Kmv+XUYxvrzb9ldoidKBtqWMowPZZprFNRptfbfLJSMnCR+U7QnqSSGK0nCQ9sCueKkscDegK2yo0xKeZTZwvsY2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIERg48abpLZ1D3MCSmQ6YdNRfSsaBnIeQ4wijLrInY=;
 b=F3xDisN9UIWxSws8MX8HdXvgUq0B5Ghd7YXeFOtLdVQ89zywOxMDffKRYIdPx42IVYjr71dAhDUEvDeoTgS6giIJSZ5QGHIr6L0zxlkEJeNjWtx/EaHXccJHwqm/v+7AFEYevhYBFg635VHF3fJd+21Y5t9Qh96BYGhQ/z62nQ+tSfBepb4Z2FBupYA1k/0dvTHPlZ7Njh/7y4dHVii8SP9hcdbMDlHp4RvYfFcuqGGa4mCCQnENuY4t2f3LcgC8E8xGZDd59rnxSXLCS4tFFyZ+mj756OXGK+uljKyO4s5YbmOsGVY5rwgfxh8R2VB9lqgKZ2gYNoE54TW/iI1UOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIERg48abpLZ1D3MCSmQ6YdNRfSsaBnIeQ4wijLrInY=;
 b=YGZjAGASif0r56aFBzwWVHBTsXXWvTLKPojSpaB40H5cxYbBptEVagh+JoBwQ0fUMdjbRKNBVbb+Fyj9K0cQ6MBgpxL3CyhCfYxobQy6zG382XKZqoWmv/0NDf9du6pgDaf7c439kjoFt2N1FM+HdyonxxGJHzFBjZxwVVozhfw=
Received: from CH2PR21MB1430.namprd21.prod.outlook.com (2603:10b6:610:80::17)
 by DS7PR21MB3343.namprd21.prod.outlook.com (2603:10b6:8:82::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.3; Mon, 7 Mar
 2022 23:48:07 +0000
Received: from CH2PR21MB1430.namprd21.prod.outlook.com
 ([fe80::f990:4b74:c257:7ef5]) by CH2PR21MB1430.namprd21.prod.outlook.com
 ([fe80::f990:4b74:c257:7ef5%7]) with mapi id 15.20.5081.004; Mon, 7 Mar 2022
 23:48:07 +0000
From:   Alan Jowett <Alan.Jowett@microsoft.com>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next] Support load time binding of bpf-helpers.
Thread-Topic: [PATCH bpf-next] Support load time binding of bpf-helpers.
Thread-Index: AdgyfY9KAOB35mfkQ9OERhtYbxsHug==
Date:   Mon, 7 Mar 2022 23:48:07 +0000
Message-ID: <CH2PR21MB1430AFEB81F5F7930E8027C1FA089@CH2PR21MB1430.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e1b222d6-6092-4892-b649-296b9a558b13;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-03-07T23:44:41Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60a86938-980b-4b2f-2fed-08da0094edfb
x-ms-traffictypediagnostic: DS7PR21MB3343:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <DS7PR21MB3343A9957B5AFAE8EC677D12FA089@DS7PR21MB3343.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CNOgZkOIyiE4ahVNYwMDtSNeAKhAw7qcyi6O83diTVg+Af5sMVxrL0Io0HNY49fE0bJDR7CIsEO4j9yoEZzOpbVCjG6vpWuylDSrfIYIOI7Ep6ETLy5OEtokx/v2fUL5Hfv0m3UOnfZGUq6x4gYzIrMZqivtlgXiSgcBV2c5Cg2fBfKwqVYccplYqAHP8cai+hPJtqcRUDR3S39HC+IVnNILyLi04oNfKStC/WLb8vrmVFMZfukgo0FyNRsv2HaoDQU+EDAXgtzJfcWDQu2ahoen+kgky8OHHSA38k/55AjiHJAD9fSgj5WA4XA3rgrunYgS58Y1B0fn3mZNAmJb7C2lJ6TfEtSufQ9oawrYnEK5BuJMsAqxRXWIqPZ/LZdwiCZSgK6umTTECigXyHWuTBHO+HK0pD0d5dnj2kBBbOjgDLeImIgYaXCNzidIVUoZTzTol/85PpWVfeUwy4j3QWhSTfSHf0zAnbuijCjNMutz1Pd2FFNu7jMC/VOTUq9Q9urp3ZDBUe81B72UnzAdHlMgRpUGq+vcGSWnmz0rmXIJNwPFP3IFgDcHaxl9K2qo2kjLFssV3WDnri+ltH0Bc1hbBzc15fxZoJj13eqN1yrM64ytgh6lk+fEK8kfwMwLpptcLOp7Gthn1Ar4Wh18PcIGx/XJo+nzzO5dep8fT1vjV9bHWihRetdY03jugBudEnfRg1z0FZ5DOH8VjpMWHa1GFVlpI02I1p8b2SL2G6p9ZYJ1wD2H3pqJ0X/iAPiR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR21MB1430.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(52536014)(8936002)(83380400001)(33656002)(55016003)(38100700002)(82960400001)(38070700005)(316002)(508600001)(71200400001)(7696005)(6916009)(26005)(9686003)(186003)(10290500003)(2906002)(8676002)(66946007)(76116006)(122000001)(64756008)(82950400001)(5660300002)(66556008)(66446008)(66476007)(6506007)(8990500004)(451199004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/t/M6urCP1KKyAxFn44SZlAzB/n+bQRYMN3CeZqyhMu5+Wm//H0Wwq31K1Qy?=
 =?us-ascii?Q?+HlL1uvYgqcLSycQjEmEeDPVsUmWgOJBavVJNbjEbkcDTOaMT8nUU5TeP9mG?=
 =?us-ascii?Q?L+gNmjCJzDjVWXv+lssOGrW24ZyaRxo4xnYepqAqy1YmroxGq/vcT2PkNj8H?=
 =?us-ascii?Q?AVJmuVIU9XG2tOn0tfWeoWIKnk/yD+18aBFA4dFUBJq7wsIzEv71tt3w/jzx?=
 =?us-ascii?Q?LCKRRU6JXFug+4TN4LCk32iC71yXj2LdODMN34/COCLAq6eZIRppgVkwFjqo?=
 =?us-ascii?Q?+jA8nku+8WUwNc2XE108dhemCBJErY89/X1Tj8NMlFqyAMrWTWaFG0y/NIIr?=
 =?us-ascii?Q?KRFPtJyOAcmyfRo+LeM47OQRhrcK5lxk+2+BPJJaKnm2EquujJyxbcyIm75d?=
 =?us-ascii?Q?TcZS9SfyC5vGcH0y6VfhDetjhtu4WZfQaxyO0qn7EUg8s24FP3onPfbJNfbn?=
 =?us-ascii?Q?lxj/yJueZfToPDVMc95wgSfOrY8y/jOyTlpEeqhICw6o0K07FD5Sa5otSBBm?=
 =?us-ascii?Q?+pi1TTJ+dkCON0931XQDIxfeASY4eUP6+93X2FYOaCUc9DFgyuj5tzExYAC1?=
 =?us-ascii?Q?zcvuTiRxiR6V4ojUTTp2aogFQywUWSugh8mYRarx/AQPnPoIGHryhwsp9rXE?=
 =?us-ascii?Q?Bq/hGJLPJBcAS0HAOamRTekeU7pOxpS65SAEiz3d4KfV/wdxTACv7TD0Ejwf?=
 =?us-ascii?Q?QRA/D/rcj12F7q/sVoBddhXZL3XhpvqG2/QcRVUCWapaThQO3ONqnvcLhQ/6?=
 =?us-ascii?Q?Vk9u99fvlh5XO1GUwrAzkI9I1R/Aiv/05NCRYj2S5Zfnxb29W6hWmWFEU956?=
 =?us-ascii?Q?gbMDxNv+lIzlCa+E6lvDREfH9o+Y9rdC64+tGihJ9LBAfR2veadBpiS5PPt1?=
 =?us-ascii?Q?7dG0Utf3D6bvCApPTmOOiIHm8hb0deydbz5MjVx/+s875rvE8UQBUlFSId37?=
 =?us-ascii?Q?+OFdrYVm6RkvVy8DoqB+K/RnBad11+tyzYiPtPX5C+Ap2AuP1c+h+Ay4T4xF?=
 =?us-ascii?Q?xlOuNsPyw+1rGBhEYvDVEWjxJmg70dK6EdcyfVVxzTvdZ5sy9Zqdb5n8f2pO?=
 =?us-ascii?Q?O3nrKHQuqZnaQOpL771dbg48UsTtNcef+cBeJSYCaxpWaNzL3MCfr5Z+tmsm?=
 =?us-ascii?Q?9mQjTDOnHKSYvcTohZYGRe+VKlsf5h5rueD6QvcQlG+o1XetLwzMEeojhIee?=
 =?us-ascii?Q?QKKnXSAyPyOJcAqwcj5JEcG24T07vAbrnv6raNXIz0X23ebJGLY0oZAMjlhW?=
 =?us-ascii?Q?sZEgoW33BVUnyHppZ5MzPutzLKBQmtM4P52aCeiq6AIG33SussvVNv/nLFgs?=
 =?us-ascii?Q?Hlqe+FaPXThMG1YX/gB1ENHM2IKM6vARhKJEfWWknezrnnRk1UdnSTA0OXy4?=
 =?us-ascii?Q?RtN97GWEVpTjCJV6l4gvUNaoAZGKfEiuSDWX1yULhVw2Ls5G09w/EoI327TE?=
 =?us-ascii?Q?vzDJLdqmsYaOCQ92dd1NI1rRZpOgnbnA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR21MB1430.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a86938-980b-4b2f-2fed-08da0094edfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 23:48:07.3668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7MXM27b8h3Z13jt2am9ctC06U37d0BIWet7e/R/Nhop20ahkDx4TiGYzTbS7GlBc6DpWwx2Pm1kGNt+txrxbmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3343
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF helper function names are common across different platforms, but the
id assigned to helper functions may vary. This change provides an option
to generate eBPF ELF files with relocations for helper functions which
permits resolving helper function names to ids at load time instead of
at compile time.

Add a level of indirection to bpf_doc.py (and generated bpf_helper_defs.h)
to permit compile time generation of bpf-helper function declarations to
facilitating late binding of bpf-helpers to helper id for cases where
different platforms use different helper ids, but the same helper
functions.

Example use case would be:
"#define BPF_HELPER(return_type, name, args, id) \
    extern return_type name args"

To generate:
extern void * bpf_map_lookup_elem (void *map, const void *key);

Instead of:
static void *(*bpf_map_lookup_elem) (void *map, const void *key) \
    =3D (void*) 1;

This would result in the bpf-helpers having external linkage and permit
late binding of BPF programs to helper function ids.

Signed-off-by: Alan Jowett <alanjo@microsoft.com>
---
 scripts/bpf_helpers_doc.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/bpf_helpers_doc.py b/scripts/bpf_helpers_doc.py
index 867ada23281c..442b5e87687e 100755
--- a/scripts/bpf_helpers_doc.py
+++ b/scripts/bpf_helpers_doc.py
@@ -519,6 +519,10 @@ class PrinterHelpers(Printer):
         for fwd in self.type_fwds:
             print('%s;' % fwd)
         print('')
+        print('#ifndef BPF_HELPER')
+        print('#define BPF_HELPER(return_type, name, args, id) static retu=
rn_type(*name) args =3D (void*) id')
+        print('#endif')
+        print('')
=20
     def print_footer(self):
         footer =3D ''
@@ -558,7 +562,7 @@ class PrinterHelpers(Printer):
                 print(' *{}{}'.format(' \t' if line else '', line))
=20
         print(' */')
-        print('static %s %s(*%s)(' % (self.map_type(proto['ret_type']),
+        print('BPF_HELPER(%s%s, %s, (' % (self.map_type(proto['ret_type'])=
,
                                       proto['ret_star'], proto['name']), e=
nd=3D'')
         comma =3D ''
         for i, a in enumerate(proto['args']):
@@ -577,7 +581,7 @@ class PrinterHelpers(Printer):
             comma =3D ', '
             print(one_arg, end=3D'')
=20
-        print(') =3D (void *) %d;' % len(self.seen_helpers))
+        print('), %d);' % len(self.seen_helpers))
         print('')
=20
 ##########################################################################=
#####
--=20
2.25.1
