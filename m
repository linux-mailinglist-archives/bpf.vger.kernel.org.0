Return-Path: <bpf+bounces-3798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE3F74393B
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 12:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFA4F280E3D
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 10:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8A211CB4;
	Fri, 30 Jun 2023 10:19:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A198101C7
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 10:19:38 +0000 (UTC)
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC7C1FE7
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 03:19:35 -0700 (PDT)
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U5nJjU020011
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 03:19:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=mg6zX/4RB6+ZHbnYlgNam+LlIdjPquj3T52FYuwpZRM=;
 b=alrVeFi0jC9VKQomwrJDMi8vCybvFfSKDcZv1RND42I/WvHFvmlT+niecQME3aIgiZzg
 qH3pjbdTqUNJHEVUHWrunNezNMa3As2gFj+t7CaBCvpOSH/gT4PNL0RynwJItOE1vC/c
 LQEm+QDIQNh5Dd+IoFDWb5ZonzSvR0KkLBqTwKDFB9FvxbmB/xu3K0sufo6CZJjq6m0d
 ZGqYM+B7FO6VcOAQszQFjruJhJWFeX7fdQhigIg25r6OIpRrHLatzDUys2j+OkHYDz4h
 DiuWHNDUjdRh+myYvfs0SY2631f6F8+30VOLRUrMNx2U8VyOl9S0zZW431ymeZX2pRBg Hw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3rher91d03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 03:19:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLpuZ+9K6mcr+cYaJe68CqYkK9ANPVPfywFwf6k+tI0iuFN6bsOqhFF3sxxDHrI9Bffqvli69mQWYsx3pmiZ+vY04FaUUTAXSpHSfzPm+lAKSRz8gk78asyEJade4ddfH5+Iph3nAs3+mb6nCNX42oiy/Q2K18gN742gQLm/WORc8Dxy6ZM4zSRtPXRGSsAMRhhm06T84rJwY0rD7V+HS2/P2FMkd9qZ9svap4DsybEXaAbkO2z04XBQmDi8Z/iQ5op2Moaf5lxLbZRcoeM1XCDaPMct5Y5LAxEZXlpsBbliXKrJNBXygQ6jsKkBC6HrLW5TIzR5XH28F9gjbPpPZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mg6zX/4RB6+ZHbnYlgNam+LlIdjPquj3T52FYuwpZRM=;
 b=HF7/mFv0HOCcrW5nb9/bhJvfGBewUWhzRuBiQxHuMV47HnunvbTBts8WvXuc6lnXjJgvPERX5db24qJCjDDOEgnTd4ciNjzrNd+JLlUnQ6unM6uxiscxQLTY5OSi1BrHjQsZLqAfDO7EYgB+UfEoJDO6b9avzKC41QXZahZ8z1awdCJUtJxduOIAJDngtt6J/6Bki0SC9Pp/4tYK49SIICu5OCUQAEgD3PaKNpRwEhF1XMtsAhUSgIl/MYzSkNiH8UGsBuaiDtWmUkAQBxBLXOr2QAXlehtyV0BRKzCKr5SOti/seSFCfnyJS8vZcxm8Bj2H424w++j6zZwpYVC/zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mg6zX/4RB6+ZHbnYlgNam+LlIdjPquj3T52FYuwpZRM=;
 b=xYN0uVrtRfTVQiC+mQkaVIxMkFtnWytTs5rxOeavpm+YpKLXtp72Kg9L9gyyruLzdNGPFlt8W8RYTnbCz8MBzjFHsEtxn4gfA/fP6Vrdv80Uaaq5+RLlsVMqYPYr5W0yDAAY9G/sNeYKnHSt9fM2gMhASqevvzPXuEWMo1jFcHAjPaVr0XKB+0TiM5Se2zU8IBIFUJs0/9iET7ZgGV6S4K20+u8VeuQu4zsBknAXV92xJr92WHe/HcWpVw3Kc5JkRrJDan+EaU8tpH/zqABzUMSy8M6APrnxSa98R9JIstA8keeAvCV2+0VJtq6TQl21F4YoVvkQy03B9pdQtFVKpw==
Received: from BYAPR02MB4840.namprd02.prod.outlook.com (2603:10b6:a03:45::12)
 by CH3PR02MB9940.namprd02.prod.outlook.com (2603:10b6:610:1a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.8; Fri, 30 Jun
 2023 10:19:33 +0000
Received: from BYAPR02MB4840.namprd02.prod.outlook.com
 ([fe80::2a0b:9d9a:e360:23cf]) by BYAPR02MB4840.namprd02.prod.outlook.com
 ([fe80::2a0b:9d9a:e360:23cf%4]) with mapi id 15.20.6565.007; Fri, 30 Jun 2023
 10:19:33 +0000
From: Rob Scheepens <rob.scheepens@nutanix.com>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Using C++ with BPF (uprobes)
Thread-Topic: Using C++ with BPF (uprobes)
Thread-Index: AQHZqzxdOT6NExDgUUmu8AvIACz8wA==
Date: Fri, 30 Jun 2023 10:19:33 +0000
Message-ID: <29C54E9E-45BB-4D6A-9864-3242FEA6F5B0@nutanix.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.73.23051401
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB4840:EE_|CH3PR02MB9940:EE_
x-ms-office365-filtering-correlation-id: 02fe7a4b-9df2-484a-2b2c-08db79537f9b
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 6xabeWik3ihKZnznS1WAZ4AQFiC0hq6vNtwztwhbJEjn19Xsm4TecYkBGKPZ4+oNKT1F9xu2gHFxabStltOvPlV3gKDNKvOLG0UwEPYSBbEPVrU1nKOSqy2ZBIENsLXNxBidaGUVjIo7vS5S7DmpGKR3o3Vku5NdFKqZSkM3wJPgzIhlJvvqnwQWD/vwcoT3wgui/WKSWKqwFGp0advaJ8qqpqYXbWS9+/NsrdAuYZ4Efd+EIX4bYYgAqCzNTV+eMcBTGSKLUfqxMrIz8XyIVTgIhlOcIaQvF/5axCqJAY1VOm1WDU+//C/IV7+if5fgVJmNxdUbmk34gLHgmMrpz65QuinpWqogkc7YrE0OS/3Vk9cjJvKNe59LS3CblgGMupLMxWqPzvS5XyY02FdkskFyG3l28gVKUZYANMK2sc1b3FLCbVPVlPuJZOKrFvipF/tQ0wNOrBEH41u45M0xyPYF5dbRvY9La+igQ+BN1XwXR7JzTJmcSo7PWJgcpcOKVl1Jt+GNS1R29VCd6oZAEL/HEizw1tgRMMX5biU4Lp6E5i3kF0G79yLalxMdyrh3VhuKcMD38HJm/wrzw/L6I1yZpsCd6o29MY9dYb3apX5vEbdjHr/aykMl39oGndmOoTmNUyJhX/FdBlxGyrtIEg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB4840.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(136003)(346002)(366004)(451199021)(66946007)(76116006)(66556008)(66476007)(66446008)(122000001)(2906002)(4744005)(44832011)(36756003)(8936002)(316002)(38100700002)(41300700001)(6916009)(64756008)(478600001)(6486002)(71200400001)(5660300002)(86362001)(38070700005)(6512007)(8676002)(33656002)(26005)(2616005)(186003)(6506007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZXRPSnlIekZwdnI5SUVJU2REV2FFZStBTkYxUnJibzM3Nng4TWQ1VkdrSldY?=
 =?utf-8?B?YlQ4N1o2a25GakMyckxsbjlWYmR1Yjh4UEdrUHJjc0c3RkhWOTNkVCtZdzg5?=
 =?utf-8?B?ZEp5U01odmZiMElOTjNlbDgwTHVvVTlnTXZBdjZxQmtqS3o0a0xKVTUvb1kx?=
 =?utf-8?B?RjN3NHVxY3NRSG9YQitsRDZlRzRLMG9PUEZkcXlLQ2dYMlJTeC9LNmhKREc4?=
 =?utf-8?B?ZkZOTGF1b2RQcS9Nb3I4L0JUczNUUnpiSVUzZzNLb3d3K1ZlVDNEajNzQXBp?=
 =?utf-8?B?Mk5QekpGeUNaTTNtRWJNSGN0TEdGZ0xBaGl0TEorOU1TcmlFbTI3Um02R2tR?=
 =?utf-8?B?U0lnMGFNQ3ZCbFNoMU5hcmU5MGp6a2RWdU5zUllRK3A4c2xnM0ZSZllOK3kx?=
 =?utf-8?B?U0sySkE2OE9McmtneDVGenljSjJIL01HZWpqTmFYTHJ5VFl1cEFLZ0EwaGJX?=
 =?utf-8?B?VXloUTRYNlE3WFh4RS83VzAwVG5hdUJOd1JhcHY5VVRiR3hmWjhOMWJPRTg0?=
 =?utf-8?B?OWEzWjdQalVZVVltS1k5Z2ZxR3VidjJESDZmR0xVbER2QWhObVo5NVRxY0xZ?=
 =?utf-8?B?bzJLSVpvN2hCejVMMzhHcWRtUG9TZTE4N0lPVUI1elFRRTJ2eklzdjRMcnJT?=
 =?utf-8?B?QzZqaXhCWTh3STRTY2VlUHgzTlNkSDMyS1M2RERYaCsrU0ZMSTRrOVVyRlMz?=
 =?utf-8?B?SncvQVlWMFY3a3UxYyswd1FDNHVBYU53cm85aTJMOGNjV0N5S1VRdWk0dm1j?=
 =?utf-8?B?K3hrOVpyVWNxaHFSaXJqMlI5c3RhOXA5MFlBZ1JKWjFFUjQ4c2QvNHdhWVF1?=
 =?utf-8?B?ME9FYmdRVGFUNkQ1UHFZT2x5eTVGQTNWSTd4OUl3U2k4MUYxT1JtaHVIeUlC?=
 =?utf-8?B?Wkl1QkpHLzlZZWpIUk5DK0tCL0NBSGVyanNjUk9YUThMVFFacFliQnlwZkpO?=
 =?utf-8?B?bytGaUk0aUs4RER3YTVFa3dMdnU5cytVSDdvQzk1TTFIUGoyT0poS0xkWTRh?=
 =?utf-8?B?djlZOUVDbWQ3QjNOc3RpTXkvREZPdk1TWi9oSGg4SEw1SS95RmJIaUpQWlJj?=
 =?utf-8?B?U2lQdnRnVUg1NGJpeVowaEtkY3pBUTgwVC90ZittWHJtb2lpQi9xMUdRN2g3?=
 =?utf-8?B?K2pvOXBkdkRRTCtiNnM3enh1cHVadXltSnJCeThncnh1ZjBUZFZ4dEVDTVpG?=
 =?utf-8?B?c1RtN2JWWVdsQ1pLL2VOUU5rYkFCUUlJOVNYOEU3M05rd3BoS0xLM3dodGxK?=
 =?utf-8?B?YkFaZE9udVFjTWloYXFyS1gwNzZvVDNhVDBxeExqakFoK01TNjJORUVGTWxJ?=
 =?utf-8?B?T3AyYnlmdE5jVVV3ejBwQlJpZ2lhUW8rWS9DbG9tS1F0ZmFpcWVwUDAvaFhQ?=
 =?utf-8?B?RlB3Nk95N0RKWTRJNytyTUFIdm4rdUZrTTQ4WW9Nd0ZxUmVaeWhGRWpIS3hC?=
 =?utf-8?B?U1pXNTZVVFd1cmRVd2VpVGF0WVBiT0h5ckM3RjdJb2paQ2RnU2E5YXRJbWgz?=
 =?utf-8?B?UVVSK1JueTdqbnNLYjVZaUNkS1Fqb0t6QzdxcFA3QjgzNy9YS3pLZk9SQzhh?=
 =?utf-8?B?S2wwclJpaFdWcEhYeUlPNk1tWWJwUFpuaDdHYzgvYXM5OCtUMUhRVXNRR3dh?=
 =?utf-8?B?LytyVGFySjduNEJkaThhV1JiSFpNbHczMHFMWWk2ekd3dE5nbCtvQmZMMCsw?=
 =?utf-8?B?VCtHa3Q5bmg1OWtHQ0NPVzd3WEVWak0vRzB1RkJPREF2WWI5a3JHa085ajZD?=
 =?utf-8?B?ZWV3ZEUrR2RNdDNPd09lK1AwMjlCdkoreTgvQjN4V3N5WFFtZ2hlM3h0NEdG?=
 =?utf-8?B?djkybFVDbjFCZC8yZ245ZjBETzFPclA0Nlo1RkVMSFZwd0JaSFAyY29sTENl?=
 =?utf-8?B?U0k5VlR1ZHVyZXo1cGNjUEl6REpBWkNlL2FYYjB5dkp6SHA2eFpiRjU4TzQr?=
 =?utf-8?B?WlFnUEtPbDJtMVk2R2UyRDduQW8yb3htWHM1cnNDRUt3YTJNOHd3OTFvbWp4?=
 =?utf-8?B?dmoyeE5PdWpMZk93cWVvcnBQQUUxSFlpem9SUzc3WjlYS1pUMEpjY3ZldVJx?=
 =?utf-8?B?N2NVZ2d2c1lLTGk3K3pzcEJVQmFaRXQ5Y1hiMC91cENNemo5c0RWL1RUbTV4?=
 =?utf-8?B?L0xZdWhxZWtUM1pKWmRDMFUxYmJlZXhqNC9pWFlKdlg3ZWViU2g3UjlKM1pT?=
 =?utf-8?B?K1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D79F43318256884A84050C44A24D868E@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4840.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fe7a4b-9df2-484a-2b2c-08db79537f9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 10:19:33.2631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: knBZEmFWrGwwkPUT1G01sheohwyeAqbBAECM692YsnBq/wf/YJX+qZXAvSyQLiupZKsr0125b89zqyIAKV1wQdi+JRQNpICWwdWRmEN0a24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9940
X-Proofpoint-GUID: G7PP8ZFyQrwuIBgByKaj_r1S-rFgVb2-
X-Proofpoint-ORIG-GUID: G7PP8ZFyQrwuIBgByKaj_r1S-rFgVb2-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SGVsbG8sDQrCoA0KSGFzIHRoZXJlIGJlZW4gd29yayBkb25lIG9uIHVzaW5nIEMrKyB2YXJpYWJs
ZXMgYW5kIHN1Y2ggZnJvbSBCUEYgcHJvZ3JhbXMsIGZvciBleGFtcGxlIHdpdGggdXByb2Jlcz8g
UGVyaGFwcyB1c2luZyBEV0FSRj8NCsKgDQpCYWNrZ3JvdW5kOiB3ZSBoYXZlIGEgQysrIGFwcGxp
Y2F0aW9uIGluIHdoaWNoIHdlIHdhbnQgdG8gaW5zZXJ0IHVwcm9iZXMuIFVzaW5nIHRoZXNlIHVw
cm9iZXMgd2UgdGhlbiB3YW50IHRvIGdhdGhlciBwZXJmb3JtYW5jZSBkYXRhIGZvciBkZWJ1Z2dp
bmcgYW5kIHBlcmZvcm1hbmNlIGFuYWx5c2lzLiBJZiBuZWNlc3Nhcnkgd2UgY291bGQgYWxzbyBh
ZGQgVVNEVCB0byB0aGUgYXBwbGljYXRpb24sIGJ1dCBmb3Igbm93IHVwcm9iZXMgYXJlIHByZWZl
cnJlZC4NCsKgDQpcUm9iDQoNCg==

