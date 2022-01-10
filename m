Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE3748A31B
	for <lists+bpf@lfdr.de>; Mon, 10 Jan 2022 23:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242034AbiAJWpi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Jan 2022 17:45:38 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35940 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241804AbiAJWph (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 10 Jan 2022 17:45:37 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20AJZvTO012010
        for <bpf@vger.kernel.org>; Mon, 10 Jan 2022 14:45:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=EJbbCUZwrO2CnrcwgE5GxI0aoXuycMXgOE3W9neF0ZI=;
 b=jU2Wnirz8cwArI93cDRlRszCczF8BZoiTTtN8rdp5EQqrI6NaiixZQk3pL5dpJIIqEZp
 hBeGFT+3nxCGUBQeV+Sqm0mNnHY2j0g6z/v55jHWT5UU+pgBw2P2rHqCF4ey36Mv2brX
 cAd+fsrb/qw9SevfITNPooMrYtnYvi7VNVc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dgnuw3mae-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 10 Jan 2022 14:45:37 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 10 Jan 2022 14:45:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPc04Li70i43UmzmoofOXiO/X3TxIn3ZNvondXAdzZCWHIAE9U3nua0rDX8XqHhUdzGq0Yko10iWksFXZpJjLjv8YMzjuQbdLI2hoEdqThFMUzxIGxui2ucMnDFP/zevTyH6m7Zi2c8VkKxnYYLkZqpIgCf4KDqfSsnCKv3jPRodReNAYC1Fr/PXD4ygOv4hkfjyKBVBWaGjXc+tTtmI7d+fuTLb+h6QzBCGz8leAAbns6CTlYwSG4UD4uwYqTWkFWa1OFfTiawyR8vvuZY0AiWwIrWe14Yq/MnzxL8y9s4fsQ+MHxYscWR6fPKniYr0L0NQjceScJa9ZKbtZVQBmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJbbCUZwrO2CnrcwgE5GxI0aoXuycMXgOE3W9neF0ZI=;
 b=I3r6hkzSxX+ghjq/38J0FWdTGWRoejNrZ0eNUgRyfbSM1ncT91ir2LntlgAl9OSu1b3Qps6nYlJQAvcIuIC2xBScSWsHkBjXiQ4Kvyu1y2d9p3MV9ey7a5IgW3UmoQPOSEPvUQsed36eAqEs0/VNGdl4rJIMq4+f1zZirYF+I14RCpzC5KoeyRA04d0tgCAYoxdQhTfcCl3b6sRV4K0ZtOc6NJQ+5Hh7w7fzsQVq1oC88wVKOmjKPC8Tr9WzxQdMvpn4UY/I4cS+7VwCHoVRulkAXgw0x3Q2faTZIs4LxGKzxeSHJL0o+kxwCqYS6CvJexkJDbAxxhWHpReuioymYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by BYAPR15MB2982.namprd15.prod.outlook.com (2603:10b6:a03:f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Mon, 10 Jan
 2022 22:45:34 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::6cf2:ff5b:d883:4146]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::6cf2:ff5b:d883:4146%7]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 22:45:34 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>
Subject: Re: [PATCH v4 bpf-next 0/4] Stop using
 bpf_object__find_program_by_title API
Thread-Topic: [PATCH v4 bpf-next 0/4] Stop using
 bpf_object__find_program_by_title API
Thread-Index: AQHYBnJgNfu9wpMxHEGrk6mVDXvr56xc2bk0
Date:   Mon, 10 Jan 2022 22:45:34 +0000
Message-ID: <BY5PR15MB3651847E9DD1FE73B0B38841CC509@BY5PR15MB3651.namprd15.prod.outlook.com>
References: <20220110223446.345531-1-kuifeng@fb.com>
In-Reply-To: <20220110223446.345531-1-kuifeng@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: ccd2925a-d548-8e24-ca8f-65107189f379
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b7225c3-32aa-47b9-0cb5-08d9d48aea0c
x-ms-traffictypediagnostic: BYAPR15MB2982:EE_
x-microsoft-antispam-prvs: <BYAPR15MB29825DDAC72B3EF584690D86CC509@BYAPR15MB2982.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pfPgjeizVdqNXudY7kg7V7JbxVZ2sGnppda1XJJ/GYqw+IR1xmz+jDs6Z1OnOYcNPHMnKZ+ToPOJT2MALK2jJorAJ7ooffizGkpuUj8hEveFjpdbU6tGCOWGADx0pZLxmtEzyZ3+O/Os6R5J9vG23+56j+ctoVy3sHwfy9DU5DakYStwuFhnTYP2wlQkhT6Z6LhHAOnGNidDIyyOo4yiEN179t7iNTX029rvjkfN+b0rTG8U1whSaMvXxTTq5fImyudGc//xAR/zYkRnElmUQhynbg9/OBFbcFLBcMTT1NhZG7Jzjvu05ZC0/YaL8+Zi9mdaxm1y+92bb1ZeLjPNzpLHGGowRepkFTlpjex7UIrecSw+ked0bx9KIqL+buq/02O9gMzbfi52teXmDJjF6uZHhNQ4RaWEOqzKJyAXKyL3QvfRfXxcrNNS0iEXSh3cP+3usvR9fKuwvB3/dbk4VN6lN/nhzp0DbRvM9jUEOUINWfZLTcvi/K6HjS+xPbm13870Qwei52FsoDWy6+y+Clp52ey91E/nZZ0eLo3glm0YUFvuMTR/SVzi7Geg9mcjwoardEo839wnMjLaOlFne2cOI8jA8PrLucJcDBlfU900qq6a1xZBeZFbOY0O2uaocYf/8utlltQIH+gt6x81oycWkDO1f8y0oAOPiGyjHO1wgRZEhqyZ1q0MCpr9HN58jfjPpjcsCxSxLvJ6iixqd5HTr8VlWpeowKoPS04/4GjPHwD9e+fByoz5XIdo50LR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(316002)(64756008)(71200400001)(66446008)(7696005)(66476007)(110136005)(52536014)(91956017)(66946007)(508600001)(186003)(558084003)(76116006)(55016003)(6506007)(4270600006)(8936002)(2906002)(8676002)(5660300002)(86362001)(9686003)(66556008)(38100700002)(38070700005)(33656002)(101420200003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmZ2RVJsSGoxYXR0VDYvblRGakt0VEpQdUdCbUhIZzdkOTdLeUpvZ3l0cFRY?=
 =?utf-8?B?UDI2RlZDa3NXNDMvTzQ3UW9SMytBSVJFai9BdnVPbTN0VVJ0LzlYdkIrTVRR?=
 =?utf-8?B?RVl0TXc4Sm12K3FGOFNGdldRaGNjRVNxeWVya3NOdzR2OUFHVHhPU1pWaDBJ?=
 =?utf-8?B?RXZubUlFeXJaVWIwRFh4VUNxcVpNMkYxdmprd2htUDdtWStPaGovaUdZZEp1?=
 =?utf-8?B?V3doUU1JdVN1Zk81bXFHWVBSM055bzlHclg4TVNJaGhoVi9nYm1OOUUwNzJa?=
 =?utf-8?B?d21jQng4ZjlJSFJEQUhXcUZGY3orRmd6NUUzcUZadVRTa1grSENXMzZhV0xq?=
 =?utf-8?B?dno0endMVmtGL2dVZE1RTG9LWWJTb2xmb0xvRk00V09FVHpXOHFuNGsyNVM0?=
 =?utf-8?B?S1h4T0dRak9lTTJNSEdmMnFuc0xLU00vUnoyLzg4bkp1NDR4ZHZMb0hBNEJj?=
 =?utf-8?B?aTB0VVVqMnJiVXVvQnFQL3FEejg4YTNudTNIdWZDYlhkalFwZ0lHTGJUWVcy?=
 =?utf-8?B?ZVlMc2ROL0J3Ryt3RytDYjlFVWJTVTArRmVSSnIzU2Q3a0tKak9OTWJPR0JU?=
 =?utf-8?B?a1BSbWZNQTI5R3hUbmJackI4ZDA1NEI5WEkwdEU4Q3hwUk1iMVB2UUtKeXZP?=
 =?utf-8?B?aWRYWUNaYzBNbHZNNWp5cWdkcmtYWDBtTXp3dEhTQ3N1N0R6TEhRWUhtclJn?=
 =?utf-8?B?VzMvT1pTTWhiUERHRjd4aUplT2xpaTVGalg5KzhQelRUSEZwTmplNVp0MmZa?=
 =?utf-8?B?OGtlOStrY1lrbjdqbW9KbFNjSFc2WENaZ1NHbk4vNEJQeU5zZU9BVnlhYUZD?=
 =?utf-8?B?dVV5VWpvU09LQmpoclluSi9ycUZnM1M0bGFnblBSdk51RXgxUkNlbGU3V0hh?=
 =?utf-8?B?eW9ubWlBdlh1Z0o0bUlPVFJGV3NHRG9tWXBMOXdpWllOT0lVTHF1L3ExV0lP?=
 =?utf-8?B?MWV6RGh3K3VOT3RWVVRFSmZ1ZjF2a3d2bkhPSGN3TTF0aUZ5bEZrUjBqb2NW?=
 =?utf-8?B?QSszOVZVY0xScTFTcHMyUmFMelBZYUNkQUVpMXlaOU10K3hyUWFzc2w3VUp1?=
 =?utf-8?B?Tnh4enNueXlHc3YrZ3dlcldhM0JkRW50c29lY1JnYjYzZ2JWY2lWaXAzbnVk?=
 =?utf-8?B?TnN4ODQ5S21FUUZVMit5TVB2S0c3L0hNZm9ZRmN3WnhuV2V0aC9vdTZUZmFU?=
 =?utf-8?B?ODl5RTRmMUgzQ2FPSUVLUExSL0J3VjlBQm1nWjh0ejY5N2pGalA0Y25TaDE2?=
 =?utf-8?B?TFNlYloxUXlwalFReExMNDV0SEU4c3o4WnRBaHpqSWNJNWdBQnphd0RqbW9R?=
 =?utf-8?B?RkZEM0FHNFVMVTJjOG9tSWNtdHdPNTBvOFVrM0dyajlYbkQrd29pMFpXTFIw?=
 =?utf-8?B?S09uUVZTWVI3WU80MG1NZEZsbC9HZ0hac2s1VDVlSWU0aXhCcjVPTUFCblN2?=
 =?utf-8?B?N2l4cENVR0piOEU0MTFBaWloeGw3V25Xdld2a1NrWWJhMmtPK1E3M0xqZ0JF?=
 =?utf-8?B?MmN4VERPdEVOQW01RTdTWkg0RjBSbTI1YklXT0tUamUvdHZyUkdvc2FYM213?=
 =?utf-8?B?V2g2S0ZkZGRkcjFDSi93b010TXAySS9zOWJ2d2VHYUEwbjdFQ3R4NmJsWmw3?=
 =?utf-8?B?Y2xXeTJnSml4OTlZSEhaOVFtaStJbUQzeFQvcGQ1UVNoWVJmSzhPTnlVRldX?=
 =?utf-8?B?NjdOeFlacHZwcTllbzd1OXFxUFNsUE5pMVpTY1VhS2hmNHB3OWlMa3BKWjRv?=
 =?utf-8?B?eU4zTFJLMlE0U0lDa1NWZ1BPS0FXZ2hTTUx1YUd4RXd0bUg5WXpGTW4xc0Jh?=
 =?utf-8?B?Z0lIYUN5ZzcvR3FqNjJjMUg5R0NsbDFTSHhUSGpvMGhRalIrRWNST1FaWmQ3?=
 =?utf-8?B?U1JMWGV5b2E0Y05WaVZHakw0YmovSWx6TzJ0bFFLM2VpckJPUGF4S2Z6bnZG?=
 =?utf-8?B?M1NabnJBaVNpNnhWbmdhcFZhaXBCVHpxTVgwMDFhYjFIQ3RlN3dISEpPUS9u?=
 =?utf-8?B?bEFpUk5GcitwNHdrVHdJMDIvbzI2Z0FrQ3ljQ0VDWE1TcEhWMjhmUWRRbkNW?=
 =?utf-8?B?WjhRYmg0NytWU3ArRU94U0NoNEJRZW9NaUlHTGFYbzY4TU1oOG9OOXRwdlFn?=
 =?utf-8?Q?MgbZnZbb1+H3q6KfWK0lMtXhL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7225c3-32aa-47b9-0cb5-08d9d48aea0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2022 22:45:34.6088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oakekj/iAwt7msfaDgmagY6tjxm3a2STKXpSz0r+5RYhAIZG6xY6EQFWjwmRcFv7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2982
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: tm5OLgoIScgNWjJj_6z4J9wNcPjguMZb
X-Proofpoint-ORIG-GUID: tm5OLgoIScgNWjJj_6z4J9wNcPjguMZb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-10_10,2022-01-10_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 mlxlogscore=813
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201100147
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

U29ycnkgZm9yIHNlbmRpbmcgdGhlc2UgcGF0Y2hlcyBhZ2Fpbi7CoCBJdCBpcyBhIG1pc3Rha2Uh
4oCLCgo=
