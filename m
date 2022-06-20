Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41635526B2
	for <lists+bpf@lfdr.de>; Mon, 20 Jun 2022 23:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbiFTVsE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jun 2022 17:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236831AbiFTVsC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jun 2022 17:48:02 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5655A625D
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 14:48:00 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 25KJ00p6029526
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 14:47:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=Y4X+N8q+6c+kMsj3pgFrL6Gp58sQmTSOhPVfIbxdcKo=;
 b=ZxMo1CiQBW67w6NqkhfI3QY4Rb8kWcgth88fzVbv2FKpCtz1GCca6xVoheyAe5WQq4lq
 OpKgNFxYBidQTACvqk53vXIVXqraKxOGTpRuhCWxLbSX/9Wb/RXl4/UG4n3ohBMKw4EM
 g7G+2WsPnhoNYTG0IxyVPgnnvtIfuWywnlc= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by m0089730.ppops.net (PPS) with ESMTPS id 3gsa78m441-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 14:47:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/6ZRddWh+3iYvM35zYzyQe137V49Q97mMfndzdTod2QLAaIZ6x3WwCQ2m8rU8ZbjLFGT1EMeRBshzPgs2zJsxeUzexl6i459vIknSeXe7ZjwlZZxWAD7t9+SAaM9C6l00QSkN0b3Q0+U2x/0qbFtUiA2p21MfbC60aZhfN2QuSfHLAo/dXIGZp1TAlJL+liYQkdxbcyXtWzgM2JafRvQ08yHPpaT5kf2eW4e7ojUbaTucMEUBG0ZY4sjVGbO8TQlLe4PJd5QKwiUbkvA1IuzTGCMDh7VBoFmmhacyAYLUvGsDoOEg7Sz3gYma6+zYWTFH1VgtZRmjmI//uIFKmIWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4X+N8q+6c+kMsj3pgFrL6Gp58sQmTSOhPVfIbxdcKo=;
 b=PSwt7zwIgJmtgNMWkESA5azJeJNpw3XuW9hgka3qPNwFNKL8dvCnvq7WCJ03UzICXTJot4poQKTml0YDExUNZdUMS5yi/xfhXCtOtu8I1LltQc/Q5m6bcfkJXh99ryXsMXx9Z3m4+asNQKHCzRhb5cMQxRlHNgwQ//fhtQx+gGmlycHvvKt7RlfFFR7GECTdXFLx5SdKhMxz6TQbE71TljxKug7GSlzaNVNSjlTYpglXasdhbpp7tXwO6EuNjWJxkHV/4yZbaLi12oJ7cBKjmUtsfJHRSN6hYG4jjPZWUlvARt6X+NpdriKmNFhNnNZb1O7bxBQQ1iXyd/xn9PFWXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by CH2PR15MB4310.namprd15.prod.outlook.com (2603:10b6:610:6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.21; Mon, 20 Jun
 2022 21:47:56 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::7dd5:ef16:ff0b:ac04]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::7dd5:ef16:ff0b:ac04%3]) with mapi id 15.20.5353.016; Mon, 20 Jun 2022
 21:47:56 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
Subject: [PATCH bpf-next] uprobe: gate bpf call behind BPF_EVENTS
Thread-Topic: [PATCH bpf-next] uprobe: gate bpf call behind BPF_EVENTS
Thread-Index: AQHYhO9mps9SA4NJ9UKnVUtpY1OWxg==
Date:   Mon, 20 Jun 2022 21:47:55 +0000
Message-ID: <cb8bfbbcde87ed5d811227a393ef4925f2aadb7b.camel@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d963963-9fe1-4b26-1f0e-08da53068900
x-ms-traffictypediagnostic: CH2PR15MB4310:EE_
x-microsoft-antispam-prvs: <CH2PR15MB4310B8E1FAF5010FEE5B8604C1B09@CH2PR15MB4310.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4F3chur9FNY3ZsgcdcrnEh5M2LfxYeurt4XURc2VLiWNlObwEetnfncsT5LJwrElL9yrA4d+dxQ8sY8YqCD1pcR/TgIXnD0QYdxUfs31StE2EXF13P/8DnFqBFiQuDVIo/Q/qB4PSkF1J2ZLds6AH2DBzeY6ktYK0GyfUcKosgAS+A4L1uTTvR2yMaPUyU9dA/P36ZEi5psqzCNyz52dB8lgP/GDqmlIntP4tGM1DXN2zxO/srQCOb/WusJy0mmo6u1A7w30M2ZKBAqWBjElkweGMubwsWfrNs0LWsmuGJ8cYHA6MldmRGPZr+ClJXOZMHwno0CdIHHmvzPucZsCMmeQAIzrVDu1USX0vUL10wwifTJs90WNRhVzudB19pg5LzyY4ejqAqRCAkc7GrT0Oa0jXGSaB+Y9tVWfgfWcRUel4eO7OLBsfp7HC61wE8Tu8Lf2d0Q7+ZzDPJnjt6m/AUcdOTd08dOtIE977DM0m9u9vylf8Eu1zNhcb1lqfSCF2biwVMxNPlnomAr0Z7OYy0C1h+dwvkgBa5zAqfEflynPtdYnYQVwpt98sLvSRn6YC9lPs6MPRaefSh+8x9qhWnyrwSNtLPE58Eol+5giXcdu/20LAoGoQyXHQPHezUZgOYPi6KSieisVecOOTlI2yULBDN6nML0mhRWKHkb9tm88iyZlmzF8QgmVgiprm3agZOm3OCLF0pAm+5aLJvYtJGizBkfifQoppqqxX3P7RHWgUF5uSNs9uRBLRa+tdJ1muuhmqM/UbzohMiO0fT5m21VWg4bhN8w6spiCa1fW2Eg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(4326008)(66476007)(66946007)(186003)(83380400001)(2616005)(86362001)(91956017)(76116006)(4744005)(66556008)(66446008)(38070700005)(38100700002)(64756008)(5660300002)(478600001)(2906002)(41300700001)(6512007)(122000001)(71200400001)(8676002)(8936002)(36756003)(6486002)(6506007)(110136005)(966005)(54906003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LNVRUAZ0JFMiC34MTkZ2eqJochd2YFdlvnc5+G4DgeOR8EEBNZ9cm6Ahkz?=
 =?iso-8859-1?Q?ohz9keQ/Ix+jxBLPvrWIcIzL5eOHLYZKIzXXQhYUXYhxECds68uo2ClpJp?=
 =?iso-8859-1?Q?S7OGJfXmNrEm8sJ+tvS4z9xNetGdaFQv9p5a+BZXgsL0buc/2L8F6VB9ax?=
 =?iso-8859-1?Q?AumpN0GCrCpN3xot19OeMMek+aOf2yw46CIAU3JkcJVwQ3N2ZKTZeiwQe2?=
 =?iso-8859-1?Q?s+nI69KNuGDbsn0Ag360bJWdJ94RzNeerGmjKLzZzPj6Vhg/QM0buedGgd?=
 =?iso-8859-1?Q?Fz45Dd0BWxR2VjXiJ8TQIspJsSw3lcVg+R9PNLsq9Cog2QGoiy9Xs7r0Kj?=
 =?iso-8859-1?Q?SWZoyQAGlouQvrDoKbaDx+NdfkSv7Kuvq8LA+q+PU4XdyK6k3LKcNdY4n3?=
 =?iso-8859-1?Q?mhB4Cq5/4WzX/pceNwBu5QIc2Eh1JdhB2PB5M+Tjhi4linyMIPAHu80ToP?=
 =?iso-8859-1?Q?yd5017FUSB5pdVs3MVcUi4ZllAAtChGUIboIR6YqnaAEcQ3Yar09X0XEha?=
 =?iso-8859-1?Q?Y9sDh5aVW8xe+CoWIEyMzjm8NR0L2f3vW7LyCjTAsh51Gxygew8gEwMv0q?=
 =?iso-8859-1?Q?aUuvp4MCukXsQLB3PHPXKnGJPFU0Pyy2ZtT70tfMH6qwQNV3p1UrrgMFWa?=
 =?iso-8859-1?Q?Qiv05LHrhO7kC+89fgABojZbHdyABEe2F6UrGeDZaWkOonyCNJfBp4nRUV?=
 =?iso-8859-1?Q?Fu19VJ8obtKZUXOnXHVTITdq17P708GMXoOkMO04zNg1B97FK0tgrEUGpf?=
 =?iso-8859-1?Q?L9rj2aHUw/cHcnue86HGLBroQvoorqX5Q2FQlRXwo4zPhqCJHCPfM75JXu?=
 =?iso-8859-1?Q?QXdsB4bQmf3HvUe+ohmoc00NGkY6IfRDLYYwdE+FjY7O2nFuhg9rRTgoBl?=
 =?iso-8859-1?Q?+4QU5G2I5b23Ks9tyboUtAckHeu3JTVPP0L27bCSFARAhxrTw6Lfb9xBD+?=
 =?iso-8859-1?Q?WSMwz1ehZSU+gaqfjDBXlymT61Gmvu+8e7BRTZAyJ8KXXEHDSNi0iDexN4?=
 =?iso-8859-1?Q?jjSYREO44ku1zBqlKS5r7LDHQ1XyrEmvYHBhz1I6v76IlXbXJjB6kDkwrD?=
 =?iso-8859-1?Q?ONDiqYmRg3q1/PoA72SCBFyDmL4LgY5llERYxPDUjAizt5hspO+xD640ru?=
 =?iso-8859-1?Q?lY8CbxXUhZRoiNfvckY5tcipS7bNRizb20J0v2d3rs+I3sP5mkI5SFNd0+?=
 =?iso-8859-1?Q?XIFK6dU0iO6XtUqZC5ot7U9R7z3kSjuUUOs4DbQPedPAUoALZzikPb/7er?=
 =?iso-8859-1?Q?Kw0oF/vjaZvX2bxJM/951Gi2+GxuMCisFPEVHCMo8DNTyoGrp4gESO7n8l?=
 =?iso-8859-1?Q?ufWapGdtEg+oq5OaMNH+y6mlspanFrG34NLq0BAVY5YREzvf1viMRD8BaN?=
 =?iso-8859-1?Q?SpnAX8USicLhCT2LydGrGhWwT+fFl1/qQhQoJKb6Ex4V5hv/yXEkEvG/T0?=
 =?iso-8859-1?Q?vFzSWbbDL25emixHIZNKTIy8TneCqVYJuGMJkSFAHBQ/QjQbp6FY21pIsM?=
 =?iso-8859-1?Q?rcadr8JUprW/wUa25YxyddQwzmyB1PBKkYmNu8GoC4r+Fi+HNCyPZvD5Ta?=
 =?iso-8859-1?Q?imqMdIpeB6hnM3HcmuREZsj5F7FCE+f7Ra58yHIHLUngHXct3WVkhtcFZs?=
 =?iso-8859-1?Q?qOnYc05+hwhxmZYy3bH2DiuCXgsee8fAe3gtH3lauKxLBEQuInhHMTter1?=
 =?iso-8859-1?Q?iC28ZEKqg1JEN/hk+q6Xj+NbZDwINFEaHFoxfC/q3G0cwF+0Gq4E01HUFm?=
 =?iso-8859-1?Q?b/q9i5XKm6t/ZVl12pUvBG4qqWLMDYxaeDtVcBJ18BgDtETnn/Ag2mhLGK?=
 =?iso-8859-1?Q?1/mP49THqd/1e4J1ZK8eFe6xMc+ik2DoNT2e13tdkCUQRzyzMNrx?=
Content-Type: text/plain; charset="iso-8859-1"
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d963963-9fe1-4b26-1f0e-08da53068900
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2022 21:47:55.9429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pclplPELcJ1v0rPBscEGDXXHFGQ0jtcaDJ9ARZR3EZZq8QIhsK3q69OUGuWCNBbb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB4310
X-Proofpoint-GUID: tse-JZvz5exfU0H8TFPY0dHY0aKQAdKu
X-Proofpoint-ORIG-GUID: tse-JZvz5exfU0H8TFPY0dHY0aKQAdKu
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-20_05,2022-06-17_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The call into bpf from uprobes needs to be gated now that it doesn't use
the trace_events.h helpers.

Randy found this as a randconfig build failure on linux-next [1].

  [1]: https://lore.kernel.org/linux-next/2de99180-7d55-2fdf-134d-33198c27c=
c58@infradead.org/

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 kernel/trace/trace_uprobe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 0282c119b1b2..326235fd2346 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1344,6 +1344,7 @@ static void __uprobe_perf_func(struct trace_uprobe *t=
u,
 	int size, esize;
 	int rctx;

+#ifdef CONFIG_BPF_EVENTS
 	if (bpf_prog_array_valid(call)) {
 		u32 ret;

@@ -1351,6 +1352,7 @@ static void __uprobe_perf_func(struct trace_uprobe *t=
u,
 		if (!ret)
 			return;
 	}
+#endif /* CONFIG_BPF_EVENTS */

 	esize =3D SIZEOF_TRACE_ENTRY(is_ret_probe(tu));

--
2.36.1=
