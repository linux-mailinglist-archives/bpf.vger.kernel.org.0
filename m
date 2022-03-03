Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9104CC3BC
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 18:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbiCCRaS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 12:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbiCCRaR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 12:30:17 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6133C8FA1
        for <bpf@vger.kernel.org>; Thu,  3 Mar 2022 09:29:31 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 223D0I4x001615
        for <bpf@vger.kernel.org>; Thu, 3 Mar 2022 09:29:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=BvpVLVgp7m9/fE09hnIFp1IId0p4GSXGIq12WA4/V38=;
 b=hLgEdS/L2l7Kv/BXd7ZbwNAAmWSAUhUad0k+tbamP8WpR3Gi1WJ5fuluc7ENt77Jq4v8
 YvOnOrbLwvFxTLYaLRuLNDbh5w8q2VIJUCf9nl+mViEuydqWb3vX4vGnjwfALQI5u/E8
 07VFOHBk2WdqKf2gHcOIJzN0CJ9k4IUGcQc= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ejx681t7n-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 03 Mar 2022 09:29:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2FhPFX41OOrovNzCDzeyQw+VcINdadDIn0C7EosO0r/tHJHM86cDo5kqtcTOBTX2CBGRcXNW9AEPMe1dKT52FEE8PltAz+xi/7/RtI/bpYEXXfbNfwsoybjInNVbvyox5Mc7nM+h9oGMPdsQf8WBoE5TE3mRssFzc14IQd/7FAPyY8004bDYpGkHmjXL1tWLsi5bCYkfrSwG3xn0Ad8aQlGZOlslN0MC7yJM2KgYujALTgcjYuK8di9k8/lMpW3NiS5nOLichPDSBnz9R5ryV+P/x4jRToLeKd5fVt3HIaP3c4OPrEMPwD38LuMVnAsyFJj8fxSx3qt01aW/o7row==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvpVLVgp7m9/fE09hnIFp1IId0p4GSXGIq12WA4/V38=;
 b=UzzY4HSl7QUT5YLHpZ4AO5j+7yfKUGAwJraBeTykneJJWluXW1IxE86O0KHd6pD5y3fAe+cwf1MiFPH1356M0cdwDNY00Z1kHTPFDtlM6I/yj79EYxrIia+p0PtuCaTKBzYJUI7dgzmm8VcN+k+bkG6iQsRpkAkCIJgYeNcayp26MpFN9O+fkXsdhJACjYunazQetfxNAwSW2vX7XqltUT53mWx/UPHua+cRM8vB+OKhXQYqbgXBSj9aQ+iv9PCrsKndBab9zuB6AWRvncFxN9+5PGltrD/XhoaXSJ+rS/NLU04wiU7KyDNYPdTXHddKrzPbFY0lceJgkAsCuh9BfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4732.namprd15.prod.outlook.com (2603:10b6:303:10d::15)
 by SJ0PR15MB4344.namprd15.prod.outlook.com (2603:10b6:a03:359::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Thu, 3 Mar
 2022 17:29:28 +0000
Received: from MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::94b7:4b41:35e4:4def]) by MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::94b7:4b41:35e4:4def%4]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 17:29:28 +0000
From:   Mykola Lysenko <mykolal@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
CC:     Mykola Lysenko <mykolal@fb.com>, bpf <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH v3 bpf-next] Improve BPF test stability (related to perf
 events and scheduling)
Thread-Topic: [PATCH v3 bpf-next] Improve BPF test stability (related to perf
 events and scheduling)
Thread-Index: AQHYLnxiZfEZocnpPEGc3tnOIrk6Fayty+SAgAAfmoA=
Date:   Thu, 3 Mar 2022 17:29:28 +0000
Message-ID: <2DDD6C41-0584-44F5-8D85-4460EDFB2C40@fb.com>
References: <20220302212735.3412041-1-mykolal@fb.com>
 <8bb551bc-c687-04fe-d588-6beb1495f01d@iogearbox.net>
In-Reply-To: <8bb551bc-c687-04fe-d588-6beb1495f01d@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7e12568-ea7b-44a3-5686-08d9fd3b5ea4
x-ms-traffictypediagnostic: SJ0PR15MB4344:EE_
x-microsoft-antispam-prvs: <SJ0PR15MB4344BC1E7E5778F1BB9DD542C0049@SJ0PR15MB4344.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tfwWkPrdajRcd9BHByEAn5N+tFZIUwed+ImpCPMFx3ydYNzFca/pRpRtHKnHc/7UHMxpB5KEuqsZTGSEh8xL31fVEI78+X2dJNS+YnwHJWA4wZX6anPhoWPjV5R8JAb8By1ZPeZU9CvtwXM4rvROUCZUeitaYl4EnmDLiQURVkBXBHqqE6tOcMYiBZE9Iihec2VjDEWJeNGRAbaFNbLQFMYK8CjPtChaQcWPPaE8zRE/RAJlruzXpkbxfzIByiDy0d0nR6LOyjxScdIU8x3rrG/bDzKvh+LfuUz/z1PIH8/+OLfqDDonfKA3ykOh81Z0lblU//kED+LM26OQrUa4pjad7Hmr6gyPqTRX8y3/1U8oS1Fd+mIJO0kDuP2S8J7bzkRBk70DTWOxI+8Sth3iRG8TmAdSiIudHWzhLMAIS/CsEoiEk8EWqrm4A9T18FGEQcvkjefLmo9KhWF+M1Aujb05yxYuuMp1TFuEI5+QTe+r9vvmChIdggUKuTqwJCxHQjQy9d6Bgmes5v0OGhrlvA2iDx4DcJE2jCjbYGLOgJT4lSX0SvrroBrU7Zl3mr2vv76Zzr9nQsRGleXPcpCVIhzKuBoDDEgKsQJ31pOpo9A/dQG+ADw4iBi0WfACInqpV+YXppNlJqlahLdMEpccSJZF3bOK3Jg3P2tm7MR00wnw9oGrVFGaUOjDM3hck4Xp0C74T+4iPTKZn0nKRDVJ9ayd9s6Lz5CGMXZ8OOZS1kn6Q+xu6cXxUq+HzOzp5HJf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4732.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(2616005)(38070700005)(71200400001)(2906002)(6512007)(4326008)(6506007)(33656002)(8676002)(53546011)(76116006)(316002)(8936002)(66946007)(66556008)(64756008)(66446008)(66476007)(186003)(38100700002)(36756003)(6916009)(86362001)(83380400001)(508600001)(122000001)(6486002)(5660300002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckp0TVR3Nk16a2hqMHlhUXlpUmwyN01jQnJhSGNHajhCWVV6L3h4N1QxRVVX?=
 =?utf-8?B?NnpwL3o4Ym8xaUFQVnIvdTV5OWU2SFVuczllbHBrdTNuUVBzYjZhQ0tvM1BW?=
 =?utf-8?B?K29zSXBuUnFueUo3WnFtV1NEaHhQc0RkMnA3SDJmRUxOYmZCWjV1M1ZTbGRu?=
 =?utf-8?B?M1Z2a0l3YWJHU21RVzNHcW1YeW1PSTQrWFk5QlVBSUppb0Qrem5zeDA0Um42?=
 =?utf-8?B?ZHVib3hxczhHL3JGem5YOVNaRUVMcmdHUmhjOWZMYzgvT1pvZVZVS0dSUG1o?=
 =?utf-8?B?T1BGQ1NENDMwdEJXM1hyVEJBVnpoVDdmakxyWXJWT3pqOFZwMVhnLzNKVEt2?=
 =?utf-8?B?TGhiR250OWVWTE9uT1BidGF2RzdUbHBqYklYZThSQ0Y2NWMyQzVuOFJHQmRu?=
 =?utf-8?B?aUxyVFNpL3psb242eHJrL1Bqc2RWcHprS28rT29YOERONngrRzJVVVlBek1Q?=
 =?utf-8?B?RlEvUWpMNW5lMUhCMmlKT00wS0dEZHFjSXd2d25XTHFCZ2ZIYUsxWXJlcGZW?=
 =?utf-8?B?WXRscko0VHl0Ny9JRVBiT3hzVGRLYSs3VVlhTmFjRmk5dlIzL0hzbCt6UWlO?=
 =?utf-8?B?K1ZsVURuUXp2MUpIdlFUYUtVK0lBc3c5UVBhOXl2cDdjWmMweVBrbTkrLzZX?=
 =?utf-8?B?ZWxtZDMxZlVBUURxQjB4M3VsYmpJQnlHNkRWY3dnclBMUmhITlFkMzEvSjhN?=
 =?utf-8?B?UExWTytCNDVUVWwrcEMxMUcwNVBNTTFZbXJXK0Z0TUJjUVp2UUUyQ3pMdUho?=
 =?utf-8?B?QzJkbWxsbUk1elhGampqUFY1SDVSSlBlVkg0a3lXQTh5RUh0ajNudDhvMVdR?=
 =?utf-8?B?VjBCUlpvVjZOY0tLNk14UEV0blQ1djNDd0dIZjl4ZGlpTXY5bTFoWUhHY1Z6?=
 =?utf-8?B?SUg1ZWxLZEl3bS9rWjBwWkJIMkVRd2xXTUFnTXA2eTR6d1NaaFpiSm50MVdV?=
 =?utf-8?B?TnZyNGhoT2IxdE1tajZwM29CVC9QRUZ4YTBhRVI0OEs1U1NOTG5TQ3FlUzZk?=
 =?utf-8?B?a21Gb2lVN21kelRRZzk1WksxN3VVdm1JT1h3L2w4QncxSmJ6amlJR0ZUckpF?=
 =?utf-8?B?TmkybDh4NDBtYng2RlFCTTU0cDFoWE9vYkp5dU5nS3NudWxjNnp1VlFpMncy?=
 =?utf-8?B?WmRlRFFKT0dUdmp0NVF6WWl2VDJsOFZvTW9PMldKOW40OWF1RTZJejdSRFVl?=
 =?utf-8?B?NXU1S0FVNE9mLzZ3b3NTQ3BjRnpuUjFoSnMxZG4rb3IxYWoxWVF3eUdYeEpa?=
 =?utf-8?B?NlhLSGhQcDdGMVV5aTFzRnIrMkNuSHh6Sy94WitoYjJwTFFvRWR5aVhLU3Jo?=
 =?utf-8?B?RlI1ODBiOTNSckFOUWdKeWhacVlCaTFvRjVZbi9aTUt2QVpjdXJIaFB5RnF2?=
 =?utf-8?B?dXVIOVhySmpRUWZwdlZ6SUpWWXUwYk9hTy9GSm5DV2lTaENITXRtSWtDd00x?=
 =?utf-8?B?clJPTEd3eGprSTQrOCsyQkFTaEd0Z1ViWVRjb0YvQXpvTlR6aG9kRi9FcWpn?=
 =?utf-8?B?c3pCdFJJb3hRdGFWdU8rV29wWlRjd28rMWU3K0J0M2p0WDg1QlZMdkRUNlRS?=
 =?utf-8?B?YUFnSWxQazdWbzJvazNkSUQ4Yk92bEE5aW12Z0pYQjB0K2ljRFVFUWxobGNU?=
 =?utf-8?B?ZkVBK3B4VkFWcUNtczhoK3ZXTGNJUEFnVmpNMlIvZWhtdkF6L3B4ME1aaXdO?=
 =?utf-8?B?OTFIc0p4dmNUdlNZZVMxaVZKY1FnVkM5bm9OVnFFZGR6K3d1dHRkbXpEbDYx?=
 =?utf-8?B?V01wb2VxVUk3Ym1Sc1Rpa1A3R000d3REK2RiSDIvdWs0Uk54SWs1WVdXMFBj?=
 =?utf-8?B?YTFxTFRxT2F3Mi9kMGVkVm1LRzZIQTFtUkpOVTlrbVgvSERrRkM5cGlJbzRY?=
 =?utf-8?B?MTJTeXR0QnBjTnpCMmhuOXdFTGVETVVLRGdFZktkVThycUkwaXBlNWpwb2dh?=
 =?utf-8?B?b1ZYajY1T0cxZFZXVWJId2JVNkFsUWRpeTdQeDVFSFB6NDAyZU9zOExBQ3NU?=
 =?utf-8?B?ZFNiOGd5Z3N3YjlmU1hEUFVZTDl1bUk3b2E5ZFFNKzhZZEE2OTdBRU5aOER6?=
 =?utf-8?B?UFQ4QndVbXNlY1BVQ3ZKQXNrUXFlRlRXK2s5VE94ejFjM1lDUHFXVDh3T295?=
 =?utf-8?B?V0lIVUd6a3N1dE1pY1BkbHZmckMyU1dwWUdOd0dYN29mWjhnMkk3MEVLUVFH?=
 =?utf-8?B?NXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91E2F1CD29FE62418A89C66367B947E0@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4732.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e12568-ea7b-44a3-5686-08d9fd3b5ea4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 17:29:28.1268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3COC4j+g1wvJi/AKNKnDQxScdT2REKOms9bj94iZBLiLsAdZvT/TZz87Cj15ZZOM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4344
X-Proofpoint-ORIG-GUID: vRsDiT_5ujpPFJMWAV7qGejtn-hywHai
X-Proofpoint-GUID: vRsDiT_5ujpPFJMWAV7qGejtn-hywHai
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-03_07,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 phishscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 mlxscore=0
 impostorscore=0 adultscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203030082
X-FB-Internal: deliver
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCj4gT24gTWFyIDMsIDIwMjIsIGF0IDc6MzYgQU0sIERhbmllbCBCb3JrbWFubiA8ZGFuaWVs
QGlvZ2VhcmJveC5uZXQ+IHdyb3RlOg0KPiANCj4gT24gMy8yLzIyIDEwOjI3IFBNLCBNeWtvbGEg
THlzZW5rbyB3cm90ZToNCj4+IEluIHNlbmRfc2lnbmFsLCByZXBsYWNlIHNsZWVwIHdpdGggZHVt
bXkgY3B1IGludGVuc2l2ZSBjb21wdXRhdGlvbg0KPj4gdG8gaW5jcmVhc2UgcHJvYmFiaWxpdHkg
b2YgY2hpbGQgcHJvY2VzcyBiZWluZyBzY2hlZHVsZWQuIEFkZCBmZXcNCj4+IG1vcmUgYXNzZXJ0
cy4NCj4+IEluIGZpbmRfdm1hLCByZWR1Y2Ugc2FtcGxlX2ZyZXEgYXMgaGlnaGVyIHZhbHVlcyBt
YXkgYmUgcmVqZWN0ZWQgaW4NCj4+IHNvbWUgcWVtdSBzZXR1cHMsIHJlbW92ZSB1c2xlZXAgYW5k
IGluY3JlYXNlIGxlbmd0aCBvZiBjcHUgaW50ZW5zaXZlDQo+PiBjb21wdXRhdGlvbi4NCj4+IElu
IGJwZl9jb29raWUsIHBlcmZfbGluayBhbmQgcGVyZl9icmFuY2hlcywgcmVkdWNlIHNhbXBsZV9m
cmVxIGFzDQo+PiBoaWdoZXIgdmFsdWVzIG1heSBiZSByZWplY3RlZCBpbiBzb21lIHFlbXUgc2V0
dXBzDQo+PiBTaWduZWQtb2ZmLWJ5OiBNeWtvbGEgTHlzZW5rbyA8bXlrb2xhbEBmYi5jb20+DQo+
PiBBY2tlZC1ieTogWW9uZ2hvbmcgU29uZyA8eWhzQGZiLmNvbT4NCj4+IC0tLQ0KPj4gIC4uLi9z
ZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvYnBmX2Nvb2tpZS5jICAgICAgIHwgIDIgKy0NCj4+ICAu
Li4vdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvZmluZF92bWEuYyB8IDEzICsrKysr
KysrKystLS0NCj4+ICAuLi4vc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3BlcmZfYnJhbmNoZXMu
YyAgICB8ICA0ICsrLS0NCj4+ICAuLi4vc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3BlcmZfbGlu
ay5jICAgICAgICB8ICAyICstDQo+PiAgLi4uL3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0cy9zZW5k
X3NpZ25hbC5jICAgICAgfCAxNyArKysrKysrKysrLS0tLS0tLQ0KPj4gIC4uLi9zZWxmdGVzdHMv
YnBmL3Byb2dzL3Rlc3Rfc2VuZF9zaWduYWxfa2Vybi5jIHwgIDIgKy0NCj4+ICA2IGZpbGVzIGNo
YW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0KPj4gZGlmZiAtLWdpdCBh
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL2JwZl9jb29raWUuYyBiL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL2JwZl9jb29raWUuYw0KPj4gaW5k
ZXggY2QxMGRmNmNkMGZjLi4wNjEyZTc5YTkyODEgMTAwNjQ0DQo+PiAtLS0gYS90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0cy9icGZfY29va2llLmMNCj4+ICsrKyBiL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL2JwZl9jb29raWUuYw0KPj4gQEAgLTE5
OSw3ICsxOTksNyBAQCBzdGF0aWMgdm9pZCBwZV9zdWJ0ZXN0KHN0cnVjdCB0ZXN0X2JwZl9jb29r
aWUgKnNrZWwpDQo+PiAgCWF0dHIudHlwZSA9IFBFUkZfVFlQRV9TT0ZUV0FSRTsNCj4+ICAJYXR0
ci5jb25maWcgPSBQRVJGX0NPVU5UX1NXX0NQVV9DTE9DSzsNCj4+ICAJYXR0ci5mcmVxID0gMTsN
Cj4+IC0JYXR0ci5zYW1wbGVfZnJlcSA9IDQwMDA7DQo+PiArCWF0dHIuc2FtcGxlX2ZyZXEgPSAx
MDAwOw0KPj4gIAlwZmQgPSBzeXNjYWxsKF9fTlJfcGVyZl9ldmVudF9vcGVuLCAmYXR0ciwgLTEs
IDAsIC0xLCBQRVJGX0ZMQUdfRkRfQ0xPRVhFQyk7DQo+PiAgCWlmICghQVNTRVJUX0dFKHBmZCwg
MCwgInBlcmZfZmQiKSkNCj4+ICAJCWdvdG8gY2xlYW51cDsNCj4+IGRpZmYgLS1naXQgYS90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0cy9maW5kX3ZtYS5jIGIvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvZmluZF92bWEuYw0KPj4gaW5kZXggYjc0YjNj
MGM1NTVhLi43Y2Y0ZmViNjQ2NGMgMTAwNjQ0DQo+PiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9icGYvcHJvZ190ZXN0cy9maW5kX3ZtYS5jDQo+PiArKysgYi90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9icGYvcHJvZ190ZXN0cy9maW5kX3ZtYS5jDQo+PiBAQCAtMzAsMTIgKzMwLDIwIEBA
IHN0YXRpYyBpbnQgb3Blbl9wZSh2b2lkKQ0KPj4gIAlhdHRyLnR5cGUgPSBQRVJGX1RZUEVfSEFS
RFdBUkU7DQo+PiAgCWF0dHIuY29uZmlnID0gUEVSRl9DT1VOVF9IV19DUFVfQ1lDTEVTOw0KPj4g
IAlhdHRyLmZyZXEgPSAxOw0KPj4gLQlhdHRyLnNhbXBsZV9mcmVxID0gNDAwMDsNCj4+ICsJYXR0
ci5zYW1wbGVfZnJlcSA9IDEwMDA7DQo+PiAgCXBmZCA9IHN5c2NhbGwoX19OUl9wZXJmX2V2ZW50
X29wZW4sICZhdHRyLCAwLCAtMSwgLTEsIFBFUkZfRkxBR19GRF9DTE9FWEVDKTsNCj4+ICAgIAly
ZXR1cm4gcGZkID49IDAgPyBwZmQgOiAtZXJybm87DQo+PiAgfQ0KPj4gICtzdGF0aWMgYm9vbCBm
aW5kX3ZtYV9wZV9jb25kaXRpb24oc3RydWN0IGZpbmRfdm1hICpza2VsKQ0KPj4gK3sNCj4+ICsJ
cmV0dXJuIHNrZWwtPmJzcy0+Zm91bmRfdm1fZXhlYyA9PSAwIHx8DQo+PiArCQlza2VsLT5kYXRh
LT5maW5kX2FkZHJfcmV0ICE9IDAgfHwNCj4gDQo+IFNob3VsZCB0aGlzIG5vdCB0ZXN0IGZvciBg
c2tlbC0+ZGF0YS0+ZmluZF9hZGRyX3JldCA9PSAtMWAgPw0KDQpJdCBzZWVtcyB0aGF0IGZpbmRf
YWRkcl9yZXQgY2hhbmdlcyB2YWx1ZSBmZXcgdGltZXMgdW50aWwgaXQgZ2V0cyB0byAwLiBJIGFk
ZGVkIHByaW50IHN0YXRlbWVudHMgd2hlbiB2YWx1ZSBpcyBjaGFuZ2VkOg0KDQpmaW5kX2FkZHJf
cmV0IC0xID0+IGluaXRpYWwgdmFsdWUNCmZpbmRfYWRkcl9yZXQgLTE2ID0+IC1FQlVTWQ0KZmlu
ZF9hZGRyX3JldCAwID0+IGZpbmFsIHZhbHVlDQoNCkhlbmNlLCBpbiB0aGlzIGNhc2UgSSB0aGlu
ayBpdCBpcyBiZXR0ZXIgdG8gd2FpdCBmb3IgdGhlIGZpbmFsIHZhbHVlLiBXZSBkbyBoYXZlIHRp
bWUgb3V0IGluIHRoZSBsb29wIGFueXdheXMgKHdoZW4g4oCcaSIgcmVhY2hlcyAxYm4pLCBzbyB0
ZXN0IHdvdWxkIG5vdCBnZXQgc3R1Y2suDQoNClRMOkRSIGNoYW5nZSBpbiB0aGUgdGVzdCB0aGF0
IHByaW50cyB0aGVzZSB2YWx1ZXMNCg0KLSAgICAgICBmb3IgKGkgPSAwOyBpIDwgMTAwMDAwMDAw
MCAmJiBmaW5kX3ZtYV9wZV9jb25kaXRpb24oc2tlbCk7ICsraSkNCisgICAgICAgaW50IGZpbmRf
YWRkcl9yZXQgPSAtMTsNCisgICAgICAgcHJpbnRmKCJmaW5kX2FkZHJfcmV0ICVkXG4iLCBza2Vs
LT5kYXRhLT5maW5kX2FkZHJfcmV0KTsNCisNCisgICAgICAgZm9yIChpID0gMDsgaSA8IDEwMDAw
MDAwMDAgJiYgZmluZF92bWFfcGVfY29uZGl0aW9uKHNrZWwpOyArK2kpIHsNCisgICAgICAgICAg
ICAgICBpZiAoZmluZF9hZGRyX3JldCAhPSBza2VsLT5kYXRhLT5maW5kX2FkZHJfcmV0KSB7DQor
ICAgICAgICAgICAgICAgICAgICAgICBmaW5kX2FkZHJfcmV0ID0gc2tlbC0+ZGF0YS0+ZmluZF9h
ZGRyX3JldDsNCisgICAgICAgICAgICAgICAgICAgICAgIHByaW50ZigiZmluZF9hZGRyX3JldCAl
ZFxuIiwgc2tlbC0+ZGF0YS0+ZmluZF9hZGRyX3JldCk7DQorICAgICAgICAgICAgICAgfQ0KICAg
ICAgICAgICAgICAgICsrajsNCisgICAgICAgfQ0KKw0KKyAgICAgICBwcmludGYoImZpbmRfYWRk
cl9yZXQgJWRcbiIsIHNrZWwtPmRhdGEtPmZpbmRfYWRkcl9yZXQpOw0KDQo+IA0KPj4gKwkJc2tl
bC0+ZGF0YS0+ZmluZF96ZXJvX3JldCA9PSAtMSB8fA0KPj4gKwkJc3RyY21wKHNrZWwtPmJzcy0+
ZF9pbmFtZSwgInRlc3RfcHJvZ3MiKSAhPSAwOw0KPj4gK30NCj4+ICsNCj4gVGhhbmtzLA0KPiBE
YW5pZWwNCg0K
