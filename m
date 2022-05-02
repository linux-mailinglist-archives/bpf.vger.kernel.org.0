Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B635175C8
	for <lists+bpf@lfdr.de>; Mon,  2 May 2022 19:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243862AbiEBReh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 May 2022 13:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241956AbiEBReg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 May 2022 13:34:36 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EFF1161
        for <bpf@vger.kernel.org>; Mon,  2 May 2022 10:31:06 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 242CsweH003859
        for <bpf@vger.kernel.org>; Mon, 2 May 2022 10:31:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=b43RzA+EjofeCsSsREw2OFFAAFPVodLq90NTPffCxhU=;
 b=C4VR4aOrnViaUuuXvbG6vRqRbvZJ9oXRuqlkMs/HhilaLYSpkxCcFoX/3AjqnLzHQLup
 zQP75+7NcOigFgazB4UmvcTHrYT5trtfQIEabE87nZPWGtEe6fyANhy0HBVFTAt3PwvV
 qlCwlopEMkjKJSIP/dsL4i26QGQB+8hKhyQ= 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2176.outbound.protection.outlook.com [104.47.73.176])
        by m0001303.ppops.net (PPS) with ESMTPS id 3fs0suamq1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 02 May 2022 10:31:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTg6dCsj+xzP8MIdLkoaSiJNtdk15MBLyNLj8u7358Ekf9SkQu8PAvJaPAJUC/QTfu1xm16S9gdbD4yYAspnegyiDagJYEqMtweELLtlu4rPcA3wDCBM8x71qj2pZW7pLs7pHGhLrZZCGv6EBFhud4nZsHCPLAyrZ4GbmbSs8LOhFL3MTxMC9OH75yBBEexiPOb7B1oOvxaHyX+1eHdEG9kFrOe40DmbGJosmBphnFPcccyKqBv485fJDikeTuTrueGSptOv6w0NekacwLMsDCfGe4vnHhHSBzLSxDXS4l0sC+66LSr26bjZCHYVdd0aZNRlL8p+5cQx+ydoAmd1OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b43RzA+EjofeCsSsREw2OFFAAFPVodLq90NTPffCxhU=;
 b=dBSM9Llws/d67T6rfD5zi1UnoEZxazVfBmeHSqYBytRdcSEIvAFu6aqItLhMZIRFMaifVWiiCvXVuj7Jb3cEd930sAUjQFbskFMR7THXhEv/oQTxRD4JwW0SA9kNWDXBreo8V8gcwAASFs0KyZYA9/iAHdfViGtNVxdK4XBmlsgk2QJugt27bb2d5jiaXpt27QQlhpVI33tOLPiZB3kBR2pcBynbm3ojsxFzIKJ8FzaLPQH+D92HQ2Cp4GQN2eUtkNGjyWlJ9zFgN1f1NdXpitwQazLeJUadq+7/zRQJg0+OcM5MHTkJmLyySLMKbdVgByeuMk+3lZhmYUP9jRaytQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by BN6PR15MB1395.namprd15.prod.outlook.com (2603:10b6:404:c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Mon, 2 May
 2022 17:31:01 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b%5]) with mapi id 15.20.5186.028; Mon, 2 May 2022
 17:31:01 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/5] bpf: implement sleepable uprobes by chaining
 tasks and normal rcu
Thread-Topic: [PATCH bpf-next 2/5] bpf: implement sleepable uprobes by
 chaining tasks and normal rcu
Thread-Index: AQHYWyCPxeAlzkBqGUmwvbIxciSxYq0Fop2AgAAOPgCAAB5ZgIAACPuAgAAW9gCABe38gA==
Date:   Mon, 2 May 2022 17:31:01 +0000
Message-ID: <e3806766fed7bd3e6e00283995075e05ca0fc05b.camel@fb.com>
References: <cover.1651103126.git.delyank@fb.com>
         <972caeb1e9338721bb719b118e0e40705f860f50.1651103126.git.delyank@fb.com>
         <CAEf4BzYBFFtHLerimNF5ZKXa6keyb6=NfPq-5YSoPymmrc820g@mail.gmail.com>
         <c9a7e3566dc9f7e8439ab8404830847e8a960a84.camel@fb.com>
         <CAADnVQ+9axVKfyx-cCJW1NsVTcEp8BEUoAsXYiegEOsG3jmEww@mail.gmail.com>
         <cfa1255715f0fb86d699d54300b36083a68d66a5.camel@fb.com>
         <CAADnVQJqjazuUDj5Ko8ctaT1Nc-fXKriWGvzMscOfDp=5MQvcg@mail.gmail.com>
In-Reply-To: <CAADnVQJqjazuUDj5Ko8ctaT1Nc-fXKriWGvzMscOfDp=5MQvcg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5cc14e02-3460-4216-f307-08da2c61871e
x-ms-traffictypediagnostic: BN6PR15MB1395:EE_
x-microsoft-antispam-prvs: <BN6PR15MB1395B14D5B95483912AEE223C1C19@BN6PR15MB1395.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7ks3yeJTWOmX0bWvJb//Nq5goYpEMPQ6qbcYv3UxvW+b9LvzmP80c4bRRvVT8KqGvErZvDJWkHFJx+5d8JTOEjY6B/vPEJK2AhQt31j2Zgh8n4kfGMj+rM/Et+hch9EgdBk4bxBfABBtPuWKbSdKjZi28VwIsbnf/9XNrTMCjn7jAVi2Vk2j0pZgUTV/1no/d98rO9Uw07OWw7FODEoErZVSh5Bcbk5T7K9fwDSgY82gn/wl5Gbhu3clFDXWfhWymHRTiWQMX4ahhwCwyllWvzVJ/JrXYBDFbZdfE/RgnczVNxEugHThG303ATUMkcEiXTNJZ3JFp/v9fCNQXxUSzUpirAoeTuwV2+WX3HQvRsdq6exqwOqvznNs6CN3Gvh+RqyuXeYmFHOObb/KvDkumGrefjfeO36zuv7r0n0dAgI2ebCcKky10fmOrKunZtwp32a48T1eWbdnFIL+B+E4ke/Y3TvddYUkUolwADPJmHD/m7ET6PnIz5GnQ+Tg0YVb/UQ3fypgrkZw7nos0lKIL7g3htID+ozyeTbMsMnfoSAhQtnZ1tnswIlCRqbsV8+4X2Hg8cUdO/q6cM/L9np5o/Pxc3IUeevT1xtTI91XUQL8mh951sdNyw9skWe62cVKrutWuyfyIucR2lZpw+P99mYnFnbRYeXwhCOeu8aTGNcXYRN8Vw22jdhiSZo82l1wIem8jo7zs8O5wv2EfJJcoQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(36756003)(6916009)(83380400001)(2616005)(71200400001)(26005)(53546011)(6512007)(316002)(54906003)(6506007)(38100700002)(66556008)(64756008)(66476007)(66446008)(38070700005)(8936002)(66946007)(76116006)(508600001)(8676002)(4326008)(2906002)(5660300002)(6486002)(122000001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUdFV1hpUSsxU1VkMFhXNkY4bzVDc24zUFcyOTlhQzcreHg3VzkzTkorbXJm?=
 =?utf-8?B?Ui9OZHQ2VVMxbk53T3l4OW14V1VWZDRuNEs1blBCL0VXQjFiV05oKzZMS2V0?=
 =?utf-8?B?SXJ5a2ZqR1hPK1ViT3g3RE1ub210NzVCaXFGVW5FU2ZOOW1hQjJoNFdrcVZR?=
 =?utf-8?B?K3FOL2hwcjFEcDNmRUZEdnBOejFtc1ZEcWk2Z29lQWF1cHFtakxKREpJNUkx?=
 =?utf-8?B?aC9YWVlkTXk2YTFLT3RSM1ZEVDU4c0FYMWtIcloyNW9ORkV1K3paazNybVk3?=
 =?utf-8?B?alZSVW5EWWFTSSt5VjZqMzNtMjI2WTJFbjVjMmowVDBjTHQyVlZWdHI3UUJn?=
 =?utf-8?B?ZEhZcDVHanBvSnVRaGhnT01tSFhlbkd0WU1ZUEZ4LzRsUzRBOWJzMUpmbUJJ?=
 =?utf-8?B?WTZEM3JCQ3FtbU9TK0gxajdKL2lvc2RRUTc0NGg5MDFwcnl2ZDBGZUVhY29V?=
 =?utf-8?B?eVFxZUxMeXdoSXlQbHQ0SWZXSzZxN2xlZVY1bVZSRlFNc1FZN05oa3pXdU9D?=
 =?utf-8?B?UktGcmNSRnVNSFVUVk1vMnZsSGdWNzFvdWljM0FYY2U3d214djhmZ2tCKzl4?=
 =?utf-8?B?OVBzbVl4T2xCSWFUMUozMmk0SWVERytqdjFpd3BWeGVtWndPU1ZiWWNpbTYz?=
 =?utf-8?B?cHFXWUhGQTRkSEQxRnY1UVhuRGVzaW9CMlJpSzZyU3JkRlNKU0FIWTh0bkZQ?=
 =?utf-8?B?SmJqQS9Pd1dwMkN4YVVsQThlOGJzZnRzZTRtRmhnMnhSV3JGYnZOc0RBOTBm?=
 =?utf-8?B?UVpESitKMDVkeHR2Tkxndkh3TTQwWDlMUXhaV0pFdjlOMDc2QklZYkh6YVpx?=
 =?utf-8?B?VzJPR0UrbEtlMTJ2SjA4QmNYSVNmYXBURk9BbEM4akg2cUx1dHE2c1BhRkpt?=
 =?utf-8?B?TkttNFVGcUt0dmJmVTB3V2l2N0h5Mm53UXlIdEN0Szc2d04wN25YbTZOR2lG?=
 =?utf-8?B?RzdjVHo0dEMwK2V6MWZVeG44Q1VCaTZBV0tsYTZ3ZE44MjhDMVVDejlsVzZD?=
 =?utf-8?B?MU9SZHh3YVlHTGhpTG1oNWpwWVlRUUNJOUQ2Mk9lVm45emZ6YnZ6YzlWTWlT?=
 =?utf-8?B?Y3VGQlpUQ05MYW5EaGRNUFpldWs2anFDd2psUXhMZVpWZGRwNmhtTjNJWHly?=
 =?utf-8?B?bFY0UHRjY3dCK2cwa0xOcmt1aytnVGZxV0NlOVFSck5Fdk96dTJvR2ZSNVJR?=
 =?utf-8?B?RGxkb3F6OE5YVEt5Y05acGlrK1B2aVNXSnN4TzR0K0MxemtSYzdETGFiazBq?=
 =?utf-8?B?SmdmcVlDSDNkdUJ6c2ptSlV4NjhVdVpQSWw0N3ZFZkRRTVVIaW1EMVFWZ1R1?=
 =?utf-8?B?azdtbkJUckR4QUN2c0MzZmxxSFNBU3d2akNkRFJUbDVua2pOTUdRT1psQmVn?=
 =?utf-8?B?V0NoK0VhUGFGVk1hQ2s3WEZKZVlnSlpzdDJCR0tyRVRiRzFKbDJxTFNNNTZ2?=
 =?utf-8?B?ZVZ3NHdHcEQxbDFVMG10UmRhVHFVQzVIVEVQWE4zR2xZZnRQQTgrK1ZVMllM?=
 =?utf-8?B?Zmh5MWFrQk9QakoyeHYyZXQzN0xBWG1sd0dPeXlUSlNEUmJaUWM0NzBZMG1y?=
 =?utf-8?B?ZWs3ZXRHMi9BUmNUdnJ2SDFpRGVPVTNBcCttd2FRK3BySFZHNTBsK1JLYmlt?=
 =?utf-8?B?cWhaMlhrbXFneVRCT3MvN3N6THJ2SjdMTS9DaDdpODA0SDBxVEh6ek93OFc2?=
 =?utf-8?B?ekNTaFlOdUFRV1hlUmtFemRjVk8ybUxkZFpmUHBCcXc0cS9idFZqOHdveCs2?=
 =?utf-8?B?TTdleWVKMHErKy9lQmMrbXA2aDRQK2I5OE5YLytZaVZpOGZEQzFZY0dWUklz?=
 =?utf-8?B?azh4amp6RW1ZNmZWRFRkc3FGTnFpK0J4elJLT3huRDB3SjcrVVRyZzc4MndS?=
 =?utf-8?B?WFJDVmcvUzZnVUR2c3RhRm1oNTBCajkzRW9GSnF0K1NidWNLUE9VdE93MnFi?=
 =?utf-8?B?Qjg5SnQ3WmIxc3lUYjhza29CM0txMDlJUzg4S0hQNUhsZ2MvdVErRWhPT0hU?=
 =?utf-8?B?bjVmZUcyWDl0dVVlR3J5NUwvWkpEbjZEcWZLVGVteE4wbFhveDArTlJRYmNJ?=
 =?utf-8?B?SHlmbmZER2VtczdqNHVtbUVtTWd3ZUh0Z2IzbGRubnpBMEZBSC9IRGVHV0RL?=
 =?utf-8?B?TXhyaUtjRjRnSnp5ajBhYjdMK0poV0wxS1lTUXpQL0xJVVhzMkdCU0pzU1U5?=
 =?utf-8?B?TWVGL0d6QlJ5KytwbUM0UFZyVGVpaXhNQWtiVUFBL2NwZ2JmejRvSng4Y2Z2?=
 =?utf-8?B?bmNpZjhtWEh4YzZnYThQVENIbzlBNGxFeEo3eGw2djdHYTFvVTMzR0RyY3Fn?=
 =?utf-8?B?TFptRHlXVHRoeTdWY2VPZmxyazhFWnowM1p6UmN6eEo0QWVsM0pndz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <913402A0AF79EA4CBC488B84BBB82D0A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc14e02-3460-4216-f307-08da2c61871e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2022 17:31:01.6592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qOIGGVZr49CMPEs0MHgmnCUbOSS1GPApeUxz63vcxKBve1VAK9JYAZmxXctqWCs/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1395
X-Proofpoint-GUID: BiNfCGp7lvtdfid8cVKa1PBEdoUa1pXO
X-Proofpoint-ORIG-GUID: BiNfCGp7lvtdfid8cVKa1PBEdoUa1pXO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-02_05,2022-05-02_03,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVGh1LCAyMDIyLTA0LTI4IGF0IDE1OjUyIC0wNzAwLCBBbGV4ZWkgU3Rhcm92b2l0b3Ygd3Jv
dGU6DQo+IE9uIFRodSwgQXByIDI4LCAyMDIyIGF0IDI6MzUgUE0gRGVseWFuIEtyYXR1bm92IDxk
ZWx5YW5rQGZiLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gVGh1LCAyMDIyLTA0LTI4IGF0IDEz
OjU4IC0wNzAwLCBBbGV4ZWkgU3Rhcm92b2l0b3Ygd3JvdGU6DQo+ID4gPiBPbiBUaHUsIEFwciAy
OCwgMjAyMiBhdCAxMjoxNSBQTSBEZWx5YW4gS3JhdHVub3YgPGRlbHlhbmtAZmIuY29tPiB3cm90
ZToNCj4gPiA+ID4gDQo+ID4gPiA+IE9uIFRodSwgMjAyMi0wNC0yOCBhdCAxMToxOSAtMDcwMCwg
QW5kcmlpIE5ha3J5aWtvIHdyb3RlOg0KPiA+ID4gPiA+IE9uIFRodSwgQXByIDI4LCAyMDIyIGF0
IDk6NTQgQU0gRGVseWFuIEtyYXR1bm92IDxkZWx5YW5rQGZiLmNvbT4gd3JvdGU6DQo+ID4gPiA+
ID4gPiANCj4gPiA+ID4gPiA+IHVwcm9iZXMgd29yayBieSByYWlzaW5nIGEgdHJhcCwgc2V0dGlu
ZyBhIHRhc2sgZmxhZyBmcm9tIHdpdGhpbiB0aGUNCj4gPiA+ID4gPiA+IGludGVycnVwdCBoYW5k
bGVyLCBhbmQgcHJvY2Vzc2luZyB0aGUgYWN0dWFsIHdvcmsgZm9yIHRoZSB1cHJvYmUgb24gdGhl
DQo+ID4gPiA+ID4gPiB3YXkgYmFjayB0byB1c2Vyc3BhY2UuIEFzIGEgcmVzdWx0LCB1cHJvYmUg
aGFuZGxlcnMgYWxyZWFkeSBleGVjdXRlIGluIGENCj4gPiA+ID4gPiA+IHVzZXIgY29udGV4dC4g
VGhlIHByaW1hcnkgb2JzdGFjbGUgdG8gc2xlZXBhYmxlIGJwZiB1cHJvYmUgcHJvZ3JhbXMgaXMN
Cj4gPiA+ID4gPiA+IHRoZXJlZm9yZSBvbiB0aGUgYnBmIHNpZGUuDQo+ID4gPiA+ID4gPiANCj4g
PiA+ID4gPiA+IE5hbWVseSwgdGhlIGJwZl9wcm9nX2FycmF5IGF0dGFjaGVkIHRvIHRoZSB1cHJv
YmUgaXMgcHJvdGVjdGVkIGJ5IG5vcm1hbA0KPiA+ID4gPiA+ID4gcmN1IGFuZCBydW5zIHdpdGgg
ZGlzYWJsZWQgcHJlZW1wdGlvbi4gSW4gb3JkZXIgZm9yIHVwcm9iZSBicGYgcHJvZ3JhbXMNCj4g
PiA+ID4gPiA+IHRvIGJlY29tZSBhY3R1YWxseSBzbGVlcGFibGUsIHdlIG5lZWQgaXQgdG8gYmUg
cHJvdGVjdGVkIGJ5IHRoZSB0YXNrc190cmFjZQ0KPiA+ID4gPiA+ID4gcmN1IGZsYXZvciBpbnN0
ZWFkIChhbmQga2ZyZWUoKSBjYWxsZWQgYWZ0ZXIgYSBjb3JyZXNwb25kaW5nIGdyYWNlIHBlcmlv
ZCkuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IE9uZSB3YXkgdG8gYWNoaWV2ZSB0aGlzIGlz
IGJ5IHRyYWNraW5nIGFuIGFycmF5LWhhcy1jb250YWluZWQtc2xlZXBhYmxlLXByb2cNCj4gPiA+
ID4gPiA+IGZsYWcgaW4gYnBmX3Byb2dfYXJyYXkgYW5kIHN3aXRjaGluZyByY3UgZmxhdm9ycyBi
YXNlZCBvbiBpdC4gSG93ZXZlciwgdGhpcw0KPiA+ID4gPiA+ID4gaXMgZGVlbWVkIHNvbWV3aGF0
IHVud2llbGRseSBhbmQgdGhlIHJjdSBmbGF2b3IgdHJhbnNpdGlvbiB3b3VsZCBiZSBoYXJkDQo+
ID4gPiA+ID4gPiB0byByZWFzb24gYWJvdXQuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IElu
c3RlYWQsIGJhc2VkIG9uIEFsZXhlaSdzIHByb3Bvc2FsLCB3ZSBjaGFuZ2UgdGhlIGZyZWUgcGF0
aCBmb3INCj4gPiA+ID4gPiA+IGJwZl9wcm9nX2FycmF5IHRvIGNoYWluIGEgdGFza3NfdHJhY2Ug
YW5kIG5vcm1hbCBncmFjZSBwZXJpb2RzDQo+ID4gPiA+ID4gPiBvbmUgYWZ0ZXIgdGhlIG90aGVy
LiBVc2VycyB3aG8gaXRlcmF0ZSB1bmRlciB0YXNrc190cmFjZSByZWFkIHNlY3Rpb24gd291bGQN
Cj4gPiA+ID4gPiA+IGJlIHNhZmUsIGFzIHdvdWxkIHVzZXJzIHdobyBpdGVyYXRlIHVuZGVyIG5v
cm1hbCByZWFkIHNlY3Rpb25zIChmcm9tDQo+ID4gPiA+ID4gPiBub24tc2xlZXBhYmxlIGxvY2F0
aW9ucykuIFRoZSBkb3duc2lkZSBpcyB0aGF0IHdlIHRha2UgdGhlIHRhc2tzX3RyYWNlIGxhdGVu
Y3kNCj4gPiA+ID4gPiA+IHVuY29uZGl0aW9uYWxseSBidXQgdGhhdCdzIGRlZW1lZCBhY2NlcHRh
YmxlIHVuZGVyIGV4cGVjdGVkIHdvcmtsb2Fkcy4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBPbmUg
ZXhhbXBsZSB3aGVyZSB0aGlzIGFjdHVhbGx5IGNhbiBiZWNvbWUgYSBwcm9ibGVtIGlzIGNncm91
cCBCUEYNCj4gPiA+ID4gPiBwcm9ncmFtcy4gVGhlcmUgeW91IGNhbiBtYWtlIHNpbmdsZSBhdHRh
Y2htZW50IHRvIHJvb3QgY2dyb3VwLCBidXQgaXQNCj4gPiA+ID4gPiB3aWxsIGNyZWF0ZSBvbmUg
ImVmZmVjdGl2ZSIgcHJvZ19hcnJheSBmb3IgZWFjaCBkZXNjZW5kYW50IChhbmQgd2lsbA0KPiA+
ID4gPiA+IGtlZXAgZGVzdHJveWluZyBhbmQgY3JlYXRpbmcgdGhlbSBhcyBjaGlsZCBjZ3JvdXBz
IGFyZSBjcmVhdGVkKS4gU28NCj4gPiA+ID4gPiB0aGVyZSBpcyB0aGlzIGludmlzaWJsZSBtdWx0
aXBsaWVyIHdoaWNoIHdlIGNhbid0IHJlYWxseSBjb250cm9sLg0KPiA+ID4gPiA+IA0KPiA+ID4g
PiA+IFNvIHBheWluZyB0aGUgKGhvd2V2ZXIgc21hbGwsIGJ1dCkgcHJpY2Ugb2YgY2FsbF9yY3Vf
dGFza3NfdHJhY2UoKSBpbg0KPiA+ID4gPiA+IGJwZl9wcm9nX2FycmF5X2ZyZWUoKSB3aGljaCBp
cyB1c2VkIGZvciBwdXJlbHkgbm9uLXNsZWVwYWJsZSBjYXNlcw0KPiA+ID4gPiA+IHNlZW1zIHVu
Zm9ydHVuYXRlLiBCdXQgSSB0aGluayBhbiBhbHRlcm5hdGl2ZSB0byB0cmFja2luZyB0aGlzICJo
YXMNCj4gPiA+ID4gPiBzbGVlcGFibGUiIGJpdCBvbiBhIHBlciBicGZfcHJvZ19hcnJheSBjYXNl
IGlzIHRvIGhhdmUNCj4gPiA+ID4gPiBicGZfcHJvZ19hcnJheV9mcmVlX3NsZWVwYWJsZSgpIGlt
cGxlbWVudGF0aW9uIGluZGVwZW5kZW50IG9mDQo+ID4gPiA+ID4gYnBmX3Byb2dfYXJyYXlfZnJl
ZSgpIGl0c2VsZiBhbmQgY2FsbCB0aGF0IHNsZWVwYWJsZSB2YXJpYW50IGZyb20NCj4gPiA+ID4g
PiB1cHJvYmUgZGV0YWNoIGhhbmRsZXIsIGxpbWl0aW5nIHRoZSBpbXBhY3QgdG8gdGhpbmdzIHRo
YXQgYWN0dWFsbHkNCj4gPiA+ID4gPiBtaWdodCBiZSBydW5uaW5nIGFzIHNsZWVwYWJsZSBhbmQg
d2hpY2ggbW9zdCBsaWtlbHkgd29uJ3QgY2h1cm4NCj4gPiA+ID4gPiB0aHJvdWdoIGEgaHVnZSBh
bW91bnQgb2YgYXJyYXlzLiBXRFlUPw0KPiA+ID4gPiANCj4gPiA+ID4gSG9uZXN0bHksIEkgZG9u
J3QgbGlrZSB0aGUgaWRlYSBvZiBoYXZpbmcgdHdvIGRpZmZlcmVudCBBUElzLCB3aGVyZSBpZiB5
b3UgdXNlIHRoZQ0KPiA+ID4gPiB3cm9uZyBvbmUsIHRoZSBwcm9ncmFtIHdvdWxkIG9ubHkgZmFp
bCBpbiByYXJlIGFuZCB1bmRlYnVnZ2FibGUgY2lyY3Vtc3RhbmNlcy4NCj4gPiA+ID4gDQo+ID4g
PiA+IElmIHdlIG5lZWQgc3BlY2lhbGl6YXRpb24gKGFuZCBJJ20gbm90IGNvbnZpbmNlZCB3ZSBk
byAtIHdoYXQncyB0aGUgcmF0ZSBvZiBjZ3JvdXANCj4gPiA+ID4gY3JlYXRpb24gdGhhdCB3ZSBj
YW4gc3VzdGFpbj8pLCB3ZSBzaG91bGQgdHJhY2sgdGhhdCBpbiB0aGUgYnBmX3Byb2dfYXJyYXkg
aXRzZWxmLiBXZQ0KPiA+ID4gPiBjYW4gaGF2ZSB0aGUgYWxsb2NhdGlvbiBwYXRoIHNldCBhIGZs
YWcgYW5kIGJyYW5jaCBvbiBpdCBpbiBmcmVlKCkgdG8gZGV0ZXJtaW5lIHRoZQ0KPiA+ID4gPiBu
ZWNlc3NhcnkgZ3JhY2UgcGVyaW9kcy4NCj4gPiA+IA0KPiA+ID4gSSB0aGluayB3aGF0IEFuZHJp
aSBpcyBwcm9wb3NpbmcgaXMgdG8gbGVhdmUgYnBmX3Byb2dfYXJyYXlfZnJlZSgpIGFzLWlzDQo+
ID4gPiBhbmQgaW50cm9kdWNlIG5ldyBicGZfcHJvZ19hcnJheV9mcmVlX3NsZWVwYWJsZSgpICh0
aGUgd2F5IGl0IGlzIGluDQo+ID4gPiB0aGlzIHBhdGNoKSBhbmQgY2FsbCBpdCBmcm9tIDIgcGxh
Y2VzIGluIGtlcm5lbC90cmFjZS9icGZfdHJhY2UuYyBvbmx5Lg0KPiA+ID4gVGhpcyB3YXkgY2dy
b3VwIHdvbid0IGJlIGFmZmVjdGVkLg0KPiA+ID4gDQo+ID4gPiBUaGUgcmN1X3RyYWNlIHByb3Rl
Y3Rpb24gaGVyZSBhcHBsaWVzIHRvIHByb2dfYXJyYXkgaXRzZWxmLg0KPiA+ID4gTm9ybWFsIHBy
b2dzIGFyZSBzdGlsbCByY3UsIHNsZWVwYWJsZSBwcm9ncyBhcmUgcmN1X3RyYWNlLg0KPiA+ID4g
UmVnYXJkbGVzcyB3aGV0aGVyIHRoZXkncmUgY2FsbGVkIHZpYSB0cmFtcG9saW5lIG9yIHRoaXMg
bmV3IHByb2dfYXJyYXkuDQo+ID4gDQo+ID4gUmlnaHQsIEkgdW5kZXJzdGFuZCB0aGUgcHJvcG9z
YWwuIE15IG9iamVjdGlvbiBpcyB0aGF0IGlmIHRvbW9ycm93IHNvbWVvbmUgbWlzdGFrZW5seQ0K
PiA+IGtlZXBzIHVzaW5nIGJwZl9wcm9nX2FycmF5X2ZyZWUgd2hlbiB0aGV5IGFjdHVhbGx5IG5l
ZWQNCj4gPiBicGZfcHJvZ19hcnJheV9mcmVlX3NsZWVwYWJsZSwgdGhlIHJlc3VsdGluZyBidWcg
aXMgcmVhbGx5IGRpZmZpY3VsdCB0byBmaW5kIGFuZA0KPiA+IHJlYXNvbiBhYm91dC4gSSBjYW4g
bWFrZSBpdCBjb3JyZWN0IGluIHRoaXMgcGF0Y2ggc2VyaWVzIGJ1dCAqa2VlcGluZyogdGhpbmdz
IGNvcnJlY3QNCj4gPiBnb2luZyBmb3J3YXJkIHdpbGwgYmUgaGFyZGVyIHdoZW4gdGhlcmUncyB0
d28gZnJlZSB2YXJpYW50cy4NCj4gDQo+IFRoaXMga2luZCBvZiBtaXN0YWtlcyBjb2RlIHJldmll
d3MgYXJlIHN1cHBvc2VkIHRvIGNhdGNoLg0KDQpZb3UgZGVmaW5pdGVseSB0cnVzdCBjb2RlIHJl
dmlldyBtb3JlIHRoYW4gSSBkbyEgOikgDQoNCj4gPiBJbnN0ZWFkLCB3ZSBjYW4gaGF2ZSBhIEFS
UkFZX1VTRV9UUkFDRV9SQ1UgZmxhZyB3aGljaCBhdXRvbWF0aWNhbGx5IGNoYWlucyB0aGUgZ3Jh
Y2UNCj4gPiBwZXJpb2RzIGluc2lkZSBicGZfcHJvZ19hcnJheV9mcmVlLiBUaGF0IHdheSB3ZSBl
bGltaW5hdGUgcG90ZW50aWFsIGZ1dHVyZSBjb25mdXNpb24NCj4gPiBhbmQgaW5zdGVhZCBvZiBp
bnRyb2R1Y2luZyBzdWJ0bGUgcmN1IGJ1Z3MsIGF0IHdvcnN0IHlvdSBjYW4gaW5jdXIgYSBwZXJm
b3JtYW5jZQ0KPiA+IHBlbmFsdHkgYnkgdXNpbmcgdGhlIGZsYWcgd2hlcmUgeW91IGRvbid0IG5l
ZWQgaXQuIElmIHdlIHNwZW5kIHRoZSB0aW1lIHRvIG9uZS13YXkNCj4gPiBmbGlwIHRoZSBmbGFn
IG9ubHkgd2hlbiB5b3UgYWN0dWFsbHkgaW5zZXJ0IGEgc2xlZXBhYmxlIHByb2dyYW0gaW50byB0
aGUgYXJyYXksIGV2ZW4NCj4gPiB0aGF0IHBlbmFsdHkgaXMgZWxpbWluYXRlZC4NCj4gDQo+IEFy
ZSB5b3Ugc3VnZ2VzdGluZyB0byBhZGQgc3VjaCBmbGFnIGF1dG9tYXRpY2FsbHkgd2hlbg0KPiBz
bGVlcGFibGUgYnBmIHByb2dzIGFyZSBhZGRlZCB0byBwcm9nX2FycmF5Pw0KPiBUaGF0IHdvdWxk
IG5vdCBiZSBjb3JyZWN0Lg0KPiBQcmVzZW5jZSBvZiBzbGVlcGFibGUgcHJvZ3MgaGFzIG5vdGhp
bmcgdG8gZG8gd2l0aCBwcm9nX2FycmF5IGl0c2VsZi4NCj4gVGhlIGJwZl9wcm9nX2FycmF5X2Zy
ZWVbX3NsZWVwYWJsZV0oKSBmcmVlcyB0aGF0IGFycmF5Lg0KPiBOb3QgdGhlIHByb2dzIGluc2lk
ZSBpdC4NCg0KVGhlIG9ubHkgcmVhc29uIHRoZSBhcnJheSBpcyB1bmRlciB0aGUgdGFza3NfdHJh
Y2UgcmN1IGlzIHRoZSBwcmVzZW5jZSBvZiBzbGVlcGFibGUNCnByb2dyYW1zIGluc2lkZSwgc28g
SSdkIHNheSBpdCBpcyByZWxhdGVkLiBJJ20gcmVhc29uYWJseSBjZXJ0YWluIHdlIGNvdWxkDQpv
cmNoZXN0cmF0ZSB0aGUgdHJhbnNpdGlvbiBmcm9tIG9uZSByY3UgZmxhdm9yIHRvIHRoZSBvdGhl
ciBzYWZlbHkuIEFsdGVybmF0aXZlbHksIHdlDQpjYW4gaGF2ZSB0d28gcmN1X2hlYWRzIGFuZCBv
bmx5IHRha2UgdGhlIHRhc2tzX3RyYWNlIG9uZSBjb25kaXRpb25hbGx5Lg0KDQo+IElmIHlvdSBt
ZWFuIGFkZGluZyB0aGlzIGZsYWcgd2hlbiBwcm9nX2FycmF5IGlzIGFsbG9jYXRlZA0KPiBmb3Ig
dXByb2JlIGF0dGFjaG1lbnQgdGhlbiBJIGRvbid0IHNlZSBob3cgaXQgaGVscHMgY29kZSByZXZp
ZXdzLg0KPiBOb3RoaW5nIGF1dG9tYXRpYyBoZXJlLiBJdCdzIG9uZSBwbGFjZSBhbmQgc2luZ2xl
IHB1cnBvc2UgZmxhZy4NCj4gSW5zdGVhZCBvZiBkeW5hbWljYWxseSBjaGVja2luZyBpdCBpbiBm
cmVlLg0KPiBXZSBjYW4gZGlyZWN0bHkgY2FsbCB0aGUgY29ycmVjdCBmdW5jdGlvbi4NCg0KU3Vy
ZSwgSSdsbCBzZW5kIGEgdjIgd2l0aCBmcmVlX3NsZWVwYWJsZSBsYXRlciB0b2RheS4NCg==
