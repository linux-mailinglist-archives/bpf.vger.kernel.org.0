Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB5738B96B
	for <lists+bpf@lfdr.de>; Fri, 21 May 2021 00:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhETWWG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 May 2021 18:22:06 -0400
Received: from mx0b-00007101.pphosted.com ([148.163.139.28]:62096 "EHLO
        mx0b-00007101.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229750AbhETWWG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 May 2021 18:22:06 -0400
Received: from pps.filterd (m0166258.ppops.net [127.0.0.1])
        by mx0b-00007101.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14KMDI8m001571;
        Thu, 20 May 2021 22:20:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=references :
 in-reply-to : from : date : message-id : subject : to : cc : content-type
 : content-transfer-encoding : mime-version; s=campusrelays;
 bh=RJKjpAD/kxSp6H26H48Crd+7Yf7A/NW3Y6hjKq96cNM=;
 b=bk3vYZIQPGPnQMuPfYQQwKsmN8EJRdGIL+NQxfzDhhPPRiqKVNjENMQurF8BKG5MGUUE
 DH+6tFINM0d5M9IUhqBeUpGcvuRKG+LdRxXtPZXII+oNClaXhtza2XiLf3ZpMvUYI6Yz
 wKONZQtuROhpIwRJt82MogtjMyp2ecBnrST9jufmU8Hj0v8E4e4GAECzhNdwgi2rRV+B
 0wkWDnnua9ID86KPM3tygIDRhDqsETS5UbaemTkNQzdPvB5xdqDwfQLkBGrv5R62zXw0
 xv434KymtYX23GI97ElxveJd3G8KZTdYsNHfw/t1Iv1CtDNrVYrrjSnenBoWiLnONP25 6g== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2041.outbound.protection.outlook.com [104.47.74.41])
        by mx0b-00007101.pphosted.com with ESMTP id 38mx5p2pyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 May 2021 22:20:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLUwgBnRPAV5FxYKYOe9U3uddS7U/TCHQ8kGKBRm9JOLK+yfsLWi0fHXJswaMFOrGFJDYrc2UbRR+Ne1hFsxS9jeE6krjlfQd2rbfF/KZ+l9/1yNf7E6RpuEte8Is3h8+5cpfMga/cX9ZNp7x3NzRZGtznb+7nrmJVsiimJat4vyTphH1AqtoQGOTI0bJZXSdS7oC4A0o+bsK9HVCCiS69SHGuzwdEthfemKZp2c7cJir67TRJmwUbBH+00ZgzHOoq41kqh2GwstKKfLRgwGqCs/Cxh87Tr9nFIC4e+gjuhVq+qw6mnqChZJMpoek33KLERkh/vag9usfKGJanHcBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJKjpAD/kxSp6H26H48Crd+7Yf7A/NW3Y6hjKq96cNM=;
 b=d9/NJaorikWJxKL9qCNMZZMkjpofcROaK8/ZFPp1qeO0LV8V2G5Piu7wuX/6C+X4dCHkrS+S6SNJ7aOY3LQZUCVK3rxB5MOSuFAVdN5NGWKidcXxi+jWvwTZcwd1Pz7t0TbDceSTvr7FisSbfsU0+8r6rI9UPym0JsnCMrQZcbmLSCmL0AS/vArytFgF6CIrI6nteX9i5t1zhYFvj560ZI8fJMJDVOkznOcZYt12jCZfUbNwg3257S0p37jWXX8O9XAb8z9g79G9ludszW//JREviBK9JCXqEC7LKdF29N4iGFFKe6pW1JNATBanrpbBLNQQRIcofgz3mJdxdo0m3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=illinois.edu;
Received: from DM5PR11MB1692.namprd11.prod.outlook.com (2603:10b6:3:d::23) by
 DM6PR11MB2987.namprd11.prod.outlook.com (2603:10b6:5:65::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Thu, 20 May 2021 22:20:41 +0000
Received: from DM5PR11MB1692.namprd11.prod.outlook.com
 ([fe80::21bb:c117:6de2:2ac8]) by DM5PR11MB1692.namprd11.prod.outlook.com
 ([fe80::21bb:c117:6de2:2ac8%8]) with mapi id 15.20.4129.035; Thu, 20 May 2021
 22:20:41 +0000
X-Gm-Message-State: AOAM5300NjVlK+RJb0l8yl8Ylida/H85B6cbATRG6447FijgyU4UBpzY
        uTwU/9uasFCmuTOu2p+gzRM3G8A0ZX5Qab115K0=
X-Google-Smtp-Source: ABdhPJyKZE9fzXRdAm+dG1fr7f8eFaCEyQNE05qg0anNFqDQ6LuCVlYx/95p8Cw3hJfw7d1l/Q/90J1ODZsosSyazMs=
X-Received: by 2002:a25:38ca:: with SMTP id f193mr10483471yba.422.1621548832414;
 Thu, 20 May 2021 15:13:52 -0700 (PDT)
References: <cover.1620499942.git.yifeifz2@illinois.edu> <CALCETrUQBonh5BC4eomTLpEOFHVcQSz9SPcfOqNFTf2TPht4-Q@mail.gmail.com>
 <CABqSeASYRXMwTQwLfm_Tapg45VUy9sPfV7BeeV8p7XJrDoLf+Q@mail.gmail.com>
 <fffbea8189794a8da539f6082af3de8e@DM5PR11MB1692.namprd11.prod.outlook.com>
 <CAGMVDEGzGB4+6gJPTw6Tdng5ur9Jua+mCbqwPoNZ16EFaDcmjA@mail.gmail.com>
 <108b4b9c2daa4123805d2b92cf51374b@DM5PR11MB1692.namprd11.prod.outlook.com>
 <CAGMVDEEkDeUBcJAswpBjcQNWk7QDcO8BZR=uvVfm-+qe714tYg@mail.gmail.com> <00fe481c572d486289bc88780f48e88f@DM5PR11MB1692.namprd11.prod.outlook.com>
In-Reply-To: <00fe481c572d486289bc88780f48e88f@DM5PR11MB1692.namprd11.prod.outlook.com>
From:   Tianyin Xu <tyxu@illinois.edu>
Date:   Thu, 20 May 2021 17:13:41 -0500
X-Gmail-Original-Message-ID: <CAGMVDEHGgSPnzgORUSfD4a11eVvSDHp7nWNzXmTKLuQqKVNuUw@mail.gmail.com>
Message-ID: <CAGMVDEHGgSPnzgORUSfD4a11eVvSDHp7nWNzXmTKLuQqKVNuUw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next seccomp 00/12] eBPF seccomp filters
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@kernel.org>,
        YiFei Zhu <zhuyifei1999@gmail.com>,
        "containers@lists.linux.dev" <containers@lists.linux.dev>,
        bpf <bpf@vger.kernel.org>, "Zhu, YiFei" <yifeifz2@illinois.edu>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kuo, Hsuan-Chi" <hckuo2@illinois.edu>,
        Claudio Canella <claudio.canella@iaik.tugraz.at>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jann Horn <jannh@google.com>,
        "Jia, Jinghao" <jinghao7@illinois.edu>,
        "Torrellas, Josep" <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [209.85.219.175]
X-ClientProxiedBy: BN9PR03CA0756.namprd03.prod.outlook.com
 (2603:10b6:408:13a::11) To DM5PR11MB1692.namprd11.prod.outlook.com
 (2603:10b6:3:d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mail-yb1-f175.google.com (209.85.219.175) by BN9PR03CA0756.namprd03.prod.outlook.com (2603:10b6:408:13a::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.33 via Frontend Transport; Thu, 20 May 2021 22:20:41 +0000
Received: by mail-yb1-f175.google.com with SMTP id h202so4286195ybg.8;        Thu, 20 May 2021 15:20:41 -0700 (PDT)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f83ea4d5-8468-4903-0e06-08d91bdd80e7
X-MS-TrafficTypeDiagnostic: DM6PR11MB2987:
X-Microsoft-Antispam-PRVS: <DM6PR11MB2987F48A0EABE20A24A49334BB2A9@DM6PR11MB2987.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ktkH3OYw+aNFdVyvdE0j0zSy144f2ww8QFyd/m3Ay8WteLWPceGfM1+B/QoN75+CSpyz8dOn70CVTflYlegqJqHaRYur6U6iQI9HLovNPNhDlMYJW5TCUoqDVJRceFb2d4G6m/HfWKDlp28tcLvWub15dfFlUPrH8DLVkK3C9nz5mXp/hU3500KPFnuzP3T4WuR8sAxMxYo7RUbVZD1bEXhfGIa49T/B/lQOoU1R6ZJIMJVQgMyB8DfSJsxqkB3zq1WJa8e5NEvOIEq57xVcxkyfzZr7itfFaxdGlU5bYm0Sr03wz5Hv0ooOmdg/9UhpKYv2b4p8RI/n6/SeZZDoYsLtJXE3PYrXJ1K4Cb0wVTQRoy7jqELgikOhBFQ9s5y4NSjOC5Z3ivUnBgC1RRKfWb13MuK04vqHdz5EHBEo3SKXeGS1szqlX7oez1T0VJRQHI+bFBtWdA0/ogYBbLylNUWO5cLadBccJtHIWuxjShFe1hUjehxvLIiMRQOb0NSdIPc/ZsG+rHuWuZD1eCFgttYkPq6GlgFYny6lLQ1A30uUlwWVS7pEVbBFNuoDvECEXxxahSZ4BhFBLklHxCkQsrfLpTgUY7345YZ/wM5690pBaj49EEONKFdE0cq7vFtqpxPknlTqcMBhyo23fvcUSbr+oaDr5FhkvOlaIZJid92TxmS57MntYH9UFENLsDNGzh2eyr9cNfyjUlwHZ2rVeLyorDcoIo+sF66UNVjQsk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1692.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(376002)(346002)(396003)(786003)(966005)(53546011)(55236004)(66946007)(42186006)(52116002)(316002)(478600001)(450100002)(5660300002)(66476007)(107886003)(4326008)(6862004)(26005)(66556008)(86362001)(186003)(9686003)(8936002)(8676002)(83380400001)(2906002)(55446002)(75432002)(38100700002)(38350700002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?N2ljVStQNGNaZ1BxYVpmNzJSRjBMVWgyQ3VocVZXTkhrT1NiQlhickRucUx4?=
 =?utf-8?B?MGs0YlBHNHNLRXVPMHA2SzhMdkJMNmE1M3FJTFZPZDZxdzFBT0w4d0xWUFgz?=
 =?utf-8?B?cWRpQk5qeDR4Wi9tUDRDUDREV3A3SmRhZlFWNWJ5QWo1b0ZKVVR4V3VYdHNC?=
 =?utf-8?B?dGpZZUZneHdSbDFOOEFwVXNYRVFpSHFEWkg0cllRSmhMZE5MZlhrSW1ad2tn?=
 =?utf-8?B?SXVuTkgxODgrTUdWYnVWbGpTc3JHMkRRK1lLZWFHbHNEbkx5cXNPREtxMUNR?=
 =?utf-8?B?RUs0bEg2OHd3NjNFSy9kdHJHMTlnQUxFZUFlZC9XMEVRWlVGZUhjbWJOMHNs?=
 =?utf-8?B?K1pPSzdnQy80dVJvdWFnSjZsUmZWWlpEYXFjcTk1OEFMekJLNEw5QzVjNitK?=
 =?utf-8?B?RzBjZDNmUlRCZ0dUV0o3WjNPQkJ1VHBEa203bklsSWZVUnM1SmVNVm9zVFlN?=
 =?utf-8?B?TG43R3BlZTBNTzl0bU1XWUpFM0xrZzNocS9NQVhJUkorQXFVRUJHaDQ2eVZC?=
 =?utf-8?B?M0pIMGJRN2ZxZzNpSzd4VUlQTlEzSDhQbGFJeWtpeXR5QnAvbzQ3RVNodEZJ?=
 =?utf-8?B?cEx0eGlMdWpKa2Mrck8rRXZOVnZjTGo5OUtQc2owYzdmQmVEMytTWmk0eW5L?=
 =?utf-8?B?VXZwWDM0YW5YdGFPTnNnNU5PSm9lTklqa2VObE1sRVZqUCsrRHpqTzBCa3NL?=
 =?utf-8?B?Wks4N0RvQ29mMnNDaHYyQnVtMkNZSFR1YUtYaWdIRDFrMmdnbDFjUUMyM3Fz?=
 =?utf-8?B?YjdvWk5lcGlnRWdieWNUNzZXNHBzWUE5RWpjYzlzdTZhdjFsQ0R2TTJoVHlj?=
 =?utf-8?B?ZHN6Zks3M2c4R3hBd216a0pJRWhPZ1I4UTRqeDk4VU9XeFNvS1FHUVd6bmtn?=
 =?utf-8?B?SGhuY2NLT051elVMc1djSFoyTHBEUkg3ZGlCbDdpV3NXbitRNDY5S2R6OXBB?=
 =?utf-8?B?dmNlQjV6ZVkrR0c4MkdCY3V4bU9xODhYK0NBUFRZQmw5R2lJeVZmc1BGcFls?=
 =?utf-8?B?aTkxZWxKT2tCaTNnQWE5VHdTdkFhRXZ1aWtnai9lT0xsR1ZRTGU4RFpDdDh3?=
 =?utf-8?B?T2VwK3p0YWF1a3lod3FrcmozMGJrOWwxZitzeXNWaG9oV1R6eHlsTEFKclBS?=
 =?utf-8?B?T2xXcHMwOXFtaitCc2FlcnhKUnB2SDJ5cGEzVzF6RTRaVkhHYmM4dzlXcGNJ?=
 =?utf-8?B?OFAxWDlwMGxvV3U5cFUrYWxMUmFXZnlpazhwL1VZV1d2LzF1cFdZcGhtckp2?=
 =?utf-8?B?bCtONklEOHhTMEhHUVdvbVc4VzlzMjNsMzRvQWNaMG5lUzhtOUovN3VybVhN?=
 =?utf-8?B?SkJWL0ZWM1FlajV2dGtoZUZoTHdybkNzYTVIVnFrdzUyTXFnNFRIL0dNTlYy?=
 =?utf-8?B?MEZWS096ME5Rank2dTF5NFpZaVpsc2JHQVhjSTdKWkJsRG9VbzhCN0UrZzBF?=
 =?utf-8?B?UVFMYjRoRnowK2VzOGFkeGNzOUM5cXozMGJBT041cnpHSG1UbVdSYXdkY0Zp?=
 =?utf-8?B?clh0V1lvOTByeXBHbFRjN0taYjRGc3l5UUtNV2FjNkRqSGUwdjZ0SWs1K256?=
 =?utf-8?B?UFA2TkhWT0NUdjhVd1NsR1VuMjIvL3M2M0syQXJjeDYvTm4vU0xMSThVbVVr?=
 =?utf-8?B?WVBhcCtGbmFFVWdhbXFIWGp5Zm8xckw0UHBQc2IyWnZBUnVYaDhTV2YxTUpZ?=
 =?utf-8?B?SGIvakJUbE9QdTVxZTF2RkNkeGFteGZhRUwxaEZVeVNxRHRsNi9RWVUvYVoy?=
 =?utf-8?Q?L20IqmbGIURidN/vW0GMf9qVtKLCiup3YCNmNqH?=
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: f83ea4d5-8468-4903-0e06-08d91bdd80e7
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1692.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 22:20:41.6293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s16MN1/SEBQEGi+iPd6+xtRed4ZrQeuq604vDYouIStNASkHPFGz2X51caC+31HYJsHiSfk9unL5qQZY8OYgug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2987
X-Proofpoint-GUID: rPT2WCWwgZmJd5HYLP3hbJ57yj97Ylzr
X-Proofpoint-ORIG-GUID: rPT2WCWwgZmJd5HYLP3hbJ57yj97Ylzr
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105200140
X-Spam-Score: 0
X-Spam-OrigSender: tyxu@illinois.edu
X-Spam-Bar: 
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 20, 2021 at 3:56 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Thu, May 20, 2021 at 03:16:10AM -0500, Tianyin Xu wrote:
> > On Mon, May 17, 2021 at 10:40 AM Tycho Andersen <tycho@tycho.pizza> wro=
te:
> > >
> > > On Sun, May 16, 2021 at 03:38:00AM -0500, Tianyin Xu wrote:
> > > > On Sat, May 15, 2021 at 10:49 AM Andy Lutomirski <luto@kernel.org> =
wrote:
> > > > >
> > > > > On 5/10/21 10:21 PM, YiFei Zhu wrote:
> > > > > > On Mon, May 10, 2021 at 12:47 PM Andy Lutomirski <luto@kernel.o=
rg> wrote:
> > > > > >> On Mon, May 10, 2021 at 10:22 AM YiFei Zhu <zhuyifei1999@gmail=
.com> wrote:
> > > > > >>>
> > > > > >>> From: YiFei Zhu <yifeifz2@illinois.edu>
> > > > > >>>
> > > > > >>> Based on: https://urldefense.com/v3/__https://lists.linux-fou=
ndation.org/pipermail/containers/2018-February/038571.html__;!!DZ3fjg!thbAo=
RgmCeWjlv0qPDndNZW1j6Y2Kl_huVyUffr4wVbISf-aUiULaWHwkKJrNJyo$
> > > > > >>>
> > > > > >>> This patchset enables seccomp filters to be written in eBPF.
> > > > > >>> Supporting eBPF filters has been proposed a few times in the =
past.
> > > > > >>> The main concerns were (1) use cases and (2) security. We hav=
e
> > > > > >>> identified many use cases that can benefit from advanced eBPF
> > > > > >>> filters, such as:
> > > > > >>
> > > > > >> I haven't reviewed this carefully, but I think we need to dist=
inguish
> > > > > >> a few things:
> > > > > >>
> > > > > >> 1. Using the eBPF *language*.
> > > > > >>
> > > > > >> 2. Allowing the use of stateful / non-pure eBPF features.
> > > > > >>
> > > > > >> 3. Allowing the eBPF programs to read the target process' memo=
ry.
> > > > > >>
> > > > > >> I'm generally in favor of (1).  I'm not at all sure about (2),=
 and I'm
> > > > > >> even less convinced by (3).
> > > > > >>
> > > > > >>>
> > > > > >>>   * exec-only-once filter / apply filter after exec
> > > > > >>
> > > > > >> This is (2).  I'm not sure it's a good idea.
> > > > > >
> > > > > > The basic idea is that for a container runtime it may wait to e=
xecute
> > > > > > a program in a container without that program being able to exe=
cve
> > > > > > another program, stopping any attack that involves loading anot=
her
> > > > > > binary. The container runtime can block any syscall but execve =
in the
> > > > > > exec-ed process by using only cBPF.
> > > > > >
> > > > > > The use case is suggested by Andrea Arcangeli and Giuseppe Scri=
vano.
> > > > > > @Andrea and @Giuseppe, could you clarify more in case I missed
> > > > > > something?
> > > > >
> > > > > We've discussed having a notifier-using filter be able to replace=
 its
> > > > > filter.  This would allow this and other use cases without any
> > > > > additional eBPF or cBPF code.
> > > > >
> > > >
> > > > A notifier is not always a solution (even ignoring its perf overhea=
d).
> > > >
> > > > One problem, pointed out by Andrea Arcangeli, is that notifiers nee=
d
> > > > userspace daemons. So, it can hardly be used by daemonless containe=
r
> > > > engines like Podman.
> > >
> > > I'm not sure I buy this argument. Podman already has a conmon instanc=
e
> > > for each container, this could be a child of that conmon process, or
> > > live inside conmon itself.
> > >
> > > Tycho
> >
> > I checked with Andrea Arcangeli and Giuseppe Scrivano who are working o=
n Podman.
> >
> > You are right that Podman is not completely daemonless. However, =E2=80=
=9Cthe
> > fact it's no entirely daemonless doesn't imply it's a good idea to
> > make it worse and to add complexity to the background conmon daemon or
> > to add more daemons.=E2=80=9D
> >
> > TL;DR. User notifiers are surely more flexible, but are also more
> > expensive and complex to implement, compared with ebpf filters. /*
> > I=E2=80=99ll reply to Sargun=E2=80=99s performance argument in a separa=
te email */
> >
> > I'm sure you know Podman well, but let me still move some jade from
> > Andrea and Giuseppe (all credits on podmon/crun are theirs) to
> > elaborate the point, for folks cced on the list who are not very
> > familiar with Podman.
> >
> > Basically, the current order goes as follows:
> >
> >          podman -> conmon -> crun -> container_binary
> >                                \
> >                                 - seccomp done at crun level, not conmo=
n
> >
> > At runtime, what's left is:
> >
> >          conmon -> container_binary  /* podman disappears; crun disappe=
ars */
> >
> > So, to go through and use seccomp notify to block `exec`, we can
> > either start the container_binary with a seccomp agent wrapper, or
> > bloat the common binary (as pointed out by Tycho).
> >
> > If we go with the first approach, we will have:
> >
> >          podman -> conmon -> crun -> seccomp_agent -> container_binary
> >
> > So, at runtime we'd be left with one more daemon:
> >
> >         conmon -> seccomp_agent -> container_binary
>
> That seems like a strawman. I don't see why this has to be out of
> process or a separate daemon. Conmon uses a regular event loop. Adding
> support for processing notifier syscall notifications is
> straightforward. Moving it to a plugin as you mentioned below is a
> design decision not a necessity.
>
> >
> > Apparently, nobody likes one more daemon. So, the proposal from
>
> I'm not sure such a blanket statements about an indeterminate group of
> people's alleged preferences constitutes a technical argument wny we
> need ebpf in seccomp.
>
> > Giuseppe was/is to use user notifiers as plugins (.so) loaded by
> > conmon:
> > https://urldefense.com/v3/__https://github.com/containers/conmon/pull/1=
90__;!!DZ3fjg!qFZ7PXfFe7eI1Bye9J8zsGOxTQQlfL-pBh0D7Arn1YZKevtEpA9uxKqMTP9kA=
5RJ$
> > https://urldefense.com/v3/__https://github.com/containers/crun/pull/438=
__;!!DZ3fjg!qFZ7PXfFe7eI1Bye9J8zsGOxTQQlfL-pBh0D7Arn1YZKevtEpA9uxKqMTJrKzhU=
D$
> >
> > Now, with the ebpf filter support, one can implement the same thing
> > using an embarrassingly simple ebpf filter and, thanks to Giuseppe,
> > this is well supported by crun.
>
> So I think this is trying to jump the gun by saying "Look, the result
> might be simpler.". That may even be the case - though I'm not yet
> convinced - but Andy's point stands that this brings a slew of issues on
> the table that need clear answers. Bringing stateful ebpf features into
> seccomp is a pretty big step and especially around the
> privilege/security model it looks pretty handwavy right now.
>
> Christian

If an alleged gunshot was the impression I left, I apologize.
Seriously, I have great respect for user notifiers -- my intention was
never to disregard it, or to argue that ebpf filters are always
strictly better.

On the other hand, I do believe (and tried to show) ebpf filters have
their own technical advantages, and can be very useful and efficient
in many use cases. Let me know if you don=E2=80=99t buy this.

It=E2=80=99s kinda weird that we are arguing against ebpf filters with user
notifiers (it=E2=80=99s analogous to "we don=E2=80=99t need Seccomp coz we =
have
ptrace=E2=80=A6")

More importantly, I do really want to provide clear answers to the
privilege/security model, but I don=E2=80=99t precisely know what exactly
you=E2=80=99re referring to as "privilege/security model". Are you referrin=
g
to the one-way transition model of Seccomp (which may no longer be
held in stateful filters), or something different? It will be great if
you can clarify so we can answer explicitly.

Thanks!
